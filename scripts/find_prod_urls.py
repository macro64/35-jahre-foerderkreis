#!/usr/bin/env python3
import json, sys, re

pages = json.load(sys.stdin)
for p in pages:
    content = p.get('content',{}).get('rendered','')
    # Find any URL containing glas-in-lauscha.de that does NOT contain dev.
    urls = re.findall(r'https?://[^"\'<>\s]*glas-in-lauscha\.de[^"\'<>\s]*', content)
    for u in urls:
        if 'dev.' not in u:
            print(f"Page {p['id']} ({p['slug']}): PRODUCTION URL: {u}")
