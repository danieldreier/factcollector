fact collector
========

Post to fact collector with:
```bash
facter --json | curl -H "Content-Type: application/json" -d @- http://localhost
```
