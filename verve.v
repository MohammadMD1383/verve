module main

import os
import vweb
import flag

struct Server {
	vweb.Context
}

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application("verve")
	fp.version("1.0.0")
	fp.limit_free_args(0, 0)!
	fp.description("simple, fast and powerful static file server with no dependencies written in V")
	fp.skip_executable()

	help := fp.bool("help", `h`, false, "show this help message")
	verbose := fp.bool("verbose", `v`, false, "show logs")
	port := fp.int("port", `p`, 7777, "the port to be used [=7777]")
	dir := fp.string("dir", `d`, os.getwd(), "the dir to serve its content [=cwd]")

	fp.finalize() or {
		eprintln("error: use `verve --help` to see usage")
		return
	}

	if help {
		println(fp.usage())
		return
	}

	if verbose { println("[verve]: port is `$port`") }

	path := if os.is_abs_path(dir) { dir } else { os.resource_abs_path(dir) }
	if verbose { println("[verve]: dir is `$path`") }

	mut server := &Server{}
	server.mount_static_folder_at(path, "/")
	if verbose { println("[verve]: config done") }

	vweb.run(server, port)
}

["/"]
fn (mut server Server) index() vweb.Result {
	if "/index.html" in server.static_files.keys() {
		return server.file(server.static_files["/index.html"])
	}

	return server.not_found()
}
