# verve - V Serve

simple, fast and powerful static file server with no dependencies written in [V](vlang.io)

## usage

```bash
# serve current directory
verve

# serve ./prod/ directory
# use -d or --dir
verve -d prod

# set port other than 7777
# use -p or --port
verve -p 3000
```

by default verve will try to find `index.html` in the root of `<dir>` and serve it at `localhost:<port>/`

## build from source

```bash
# compile
v .

# run
./verve -d </path/to/...> -p <port>
```
