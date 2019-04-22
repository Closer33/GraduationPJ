//
//  QPServerHandler.swift
//  QPServer
//
//  Created by Mac on 2019/4/22.
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

do {
    // Launch the HTTP server on port 8181
    try HTTPServer.launch(name: "QPServer",
                          port: 8181,
                          routes: makeRoutes(),
                          responseFilters: [(try HTTPFilter.contentCompression(data: [:]), .high)])
} catch PerfectError.networkError(let err, let msg) {
    print("Network error thrown: \(err) \(msg)")
}
