# curl Cheat Sheet

The universal tool for making HTTP requests from the terminal.
Test APIs, download files, debug connections, inspect headers.

---

## Basic Requests

```bash
# GET request (default)
curl https://api.example.com/users

# With response headers shown
curl -i https://api.example.com/users

# Headers only (no body)
curl -I https://api.example.com/users

# Silent mode (no progress bar)
curl -s https://api.example.com/users

# Silent but show errors
curl -sS https://api.example.com/users

# Pretty-print JSON (pipe to jq)
curl -s https://api.example.com/users | jq .
```

## HTTP Methods

```bash
# POST with JSON body
curl -X POST https://api.example.com/users \
  -H "Content-Type: application/json" \
  -d '{"name": "Alice", "email": "alice@example.com"}'

# Shorthand: -X POST is implied when you use -d
curl https://api.example.com/users \
  -H "Content-Type: application/json" \
  -d '{"name": "Alice"}'

# POST form data
curl -X POST https://api.example.com/login \
  -d "username=alice&password=secret"

# PUT
curl -X PUT https://api.example.com/users/123 \
  -H "Content-Type: application/json" \
  -d '{"name": "Alice Updated"}'

# PATCH
curl -X PATCH https://api.example.com/users/123 \
  -H "Content-Type: application/json" \
  -d '{"name": "New Name"}'

# DELETE
curl -X DELETE https://api.example.com/users/123
```

## Headers and Auth

```bash
# Custom header
curl -H "X-API-Key: abc123" https://api.example.com/data

# Multiple headers
curl -H "Content-Type: application/json" \
     -H "Authorization: Bearer TOKEN" \
     https://api.example.com/data

# Basic auth
curl -u username:password https://api.example.com/data

# Bearer token
curl -H "Authorization: Bearer eyJhbGc..." https://api.example.com/data
```

## Reading Request Body from Files

```bash
# POST body from a file
curl -X POST https://api.example.com/users \
  -H "Content-Type: application/json" \
  -d @payload.json

# Upload a file (multipart form)
curl -X POST https://api.example.com/upload \
  -F "file=@photo.jpg"

# Multiple files
curl -X POST https://api.example.com/upload \
  -F "file1=@photo.jpg" \
  -F "file2=@doc.pdf"
```

## Debugging and Verbose Output

```bash
# Verbose mode (see full request/response exchange)
curl -v https://api.example.com/users

# Even more verbose (hex dump of traffic)
curl --trace - https://api.example.com/users

# Show timing info
curl -s -o /dev/null -w "
    DNS:        %{time_namelookup}s
    Connect:    %{time_connect}s
    TLS:        %{time_appconnect}s
    Start:      %{time_starttransfer}s
    Total:      %{time_total}s
    Status:     %{http_code}
" https://api.example.com/users

# Just get the HTTP status code
curl -s -o /dev/null -w "%{http_code}" https://api.example.com/users

# Write response headers to file
curl -D headers.txt https://api.example.com/users
```

## Downloading Files

```bash
# Save with remote filename
curl -O https://example.com/file.tar.gz

# Save with custom filename
curl -o myfile.tar.gz https://example.com/file.tar.gz

# Resume a broken download
curl -C - -O https://example.com/largefile.zip

# Follow redirects (essential for most downloads)
curl -L -O https://example.com/download

# Download multiple files
curl -O https://example.com/file1.txt -O https://example.com/file2.txt
```

## Following Redirects

```bash
# Follow redirects (-L is crucial, many URLs redirect)
curl -L https://example.com/short-url

# Follow redirects and show final URL
curl -L -w "%{url_effective}\n" -o /dev/null -s https://bit.ly/something

# Limit number of redirects
curl -L --max-redirs 3 https://example.com/url
```

## Timeouts and Retries

```bash
# Connection timeout (seconds)
curl --connect-timeout 5 https://api.example.com/data

# Max time for entire operation
curl --max-time 30 https://api.example.com/data

# Retry on failure
curl --retry 3 https://api.example.com/data

# Retry with delay between attempts
curl --retry 3 --retry-delay 2 https://api.example.com/data
```

## Common API Testing Patterns

```bash
# Test if an endpoint is up
curl -s -o /dev/null -w "%{http_code}" https://api.example.com/health

# POST JSON and pretty-print response
curl -s -X POST https://api.example.com/users \
  -H "Content-Type: application/json" \
  -d '{"name": "test"}' | jq .

# Save response to file
curl -s https://api.example.com/data > response.json

# Send request from file, save response, show status
curl -s -w "\nHTTP %{http_code}\n" \
  -X POST https://api.example.com/users \
  -H "Content-Type: application/json" \
  -d @request.json | jq .

# Loop through pages
for page in 1 2 3 4 5; do
  curl -s "https://api.example.com/users?page=$page" | jq '.data[]'
done
```

## Useful Flags Reference

| Flag | Long form | Purpose |
|------|-----------|---------|
| `-s` | `--silent` | No progress bar |
| `-S` | `--show-error` | Show errors even with -s |
| `-i` | `--include` | Show response headers |
| `-I` | `--head` | Headers only (HEAD request) |
| `-v` | `--verbose` | Full request/response debug |
| `-L` | `--location` | Follow redirects |
| `-o` | `--output` | Write to file |
| `-O` | `--remote-name` | Save with remote filename |
| `-d` | `--data` | Send data (implies POST) |
| `-H` | `--header` | Add request header |
| `-X` | `--request` | Set HTTP method |
| `-u` | `--user` | Basic auth (user:pass) |
| `-F` | `--form` | Multipart form upload |
| `-k` | `--insecure` | Skip TLS verification |
| `-w` | `--write-out` | Custom output format |
