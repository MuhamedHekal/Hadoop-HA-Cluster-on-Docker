from faker import Faker
import random
import re
import hashlib

fake = Faker()
domains = ["example.com", "test.org", "demo.net", "sample.edu", "hekal.io"]
pages = []

def escape_hbase(value):
    """Escape special characters for HBase shell commands"""
    return re.sub(r"(['\\])", r'\\\1', str(value))

def reverse_domain(domain):
    """Reverse domain (e.g., 'example.com' -> 'com.example')"""
    parts = domain.split('.')
    return '.'.join(reversed(parts))

def get_hash_prefix(domain):
    """Generate 1-byte hash (0-255) from domain"""
    hash_bytes = hashlib.md5(domain.encode()).digest()
    return hash_bytes[0]  # Returns 0-255

def build_row_key(url):
    """Generate row key: 'hash-reversed_domain:path'"""
    domain = url.split('/')[0]  # Extract domain (e.g., 'example.com')
    path = '/' + '/'.join(url.split('/')[1:]) if len(url.split('/')) > 1 else '/'
    
    reversed_domain = reverse_domain(domain)  # 'com.example'
    hash_prefix = get_hash_prefix(reversed_domain)  # Hash of 'com.example'
    
    return f"{hash_prefix}-{reversed_domain}:{path}"  # '42-com.example:/page1'

for i in range(20):
    url = f"{random.choice(domains)}/page{i+1}"
    content_size = random.choice([500, 2000, 5000])
    content = f"<html><body>{fake.text(content_size)}</body></html>"
    metadata = {
        'title': fake.sentence(),
        'status': random.choice([200, 200, 200, 404, 500]),
        'size': str(content_size),
        'created': fake.date_time_this_decade().isoformat(),
        'last_modified': fake.date_time_this_year().isoformat()
    }
    pages.append((url, content, metadata))

# Generate HBase put commands with new row keys
puts = []
inlinks_tracker = {url: [] for url, _, _ in pages}

for url, content, metadata in pages:
    row_key = build_row_key(url)  # New row key format
    
    # Insert data (using escaped row_key and values)
    puts.append(f"put 'WebTable', '{escape_hbase(row_key)}', 'Content:html', '{escape_hbase(content)}'")
    puts.append(f"put 'WebTable', '{escape_hbase(row_key)}', 'Metadata:domain', '{escape_hbase(url.split('/')[0])}'")
    puts.append(f"put 'WebTable', '{escape_hbase(row_key)}', 'Metadata:title', '{escape_hbase(metadata['title'])}'")
    puts.append(f"put 'WebTable', '{escape_hbase(row_key)}', 'Metadata:status', '{escape_hbase(metadata['status'])}'")
    puts.append(f"put 'WebTable', '{escape_hbase(row_key)}', 'Metadata:size', '{escape_hbase(metadata['size'])}'")
    puts.append(f"put 'WebTable', '{escape_hbase(row_key)}', 'Metadata:created', '{escape_hbase(metadata['created'])}'")
    puts.append(f"put 'WebTable', '{escape_hbase(row_key)}', 'Metadata:modified', '{escape_hbase(metadata['last_modified'])}'")

    # Generate outlinks
    outlinks = random.sample([p[0] for p in pages if p[0] != url], random.randint(2, 5))
    for outlink in outlinks:
        outlink_row_key = build_row_key(outlink)
        puts.append(f"put 'WebTable', '{escape_hbase(row_key)}', 'Outlinks:{escape_hbase(outlink_row_key)}', ''")
        inlinks_tracker[outlink].append(row_key)  # Track inlinks by row_key

# Add inlinks
for url, inlinks in inlinks_tracker.items():
    row_key = build_row_key(url)
    for inlink in inlinks:
        puts.append(f"put 'WebTable', '{escape_hbase(row_key)}', 'Inlinks:{escape_hbase(inlink)}', ''")

# Write to file
with open('hbase_puts.hbase', 'w') as f:
    f.write("# HBase Put Commands with Reversed-Domain + Hash\n")
    f.write("\n".join(puts))

print(f"Generated {len(puts)} put commands in hbase_puts.hbase")