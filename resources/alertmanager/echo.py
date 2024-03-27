#!/usr/bin/env python

import json
import logging

from http.server import BaseHTTPRequestHandler, HTTPServer

class RequestHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        content_length = int(self.headers['Content-Length'])
        post_data = self.rfile.read(content_length)
        try:
            formatted_json = json.dumps(json.loads(post_data.decode()), indent="  ", separators=("  ", ": "))
            logging.info(formatted_json)
        except Exception as e:
            logging.error(f"Error while formatting JSON: {e}")
        self.send_response(200)
        self.end_headers()

def main():
    logging.basicConfig(level=logging.INFO, format='%(message)s')
    server_address = ('', 5001)
    httpd = HTTPServer(server_address, RequestHandler)
    logging.info('Starting server on port 5001...')
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        pass
    httpd.server_close()
    logging.info('Stopping server...')

if __name__ == '__main__':
    main()
