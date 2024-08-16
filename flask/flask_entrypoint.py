from flask import Flask, request, jsonify
import os
import logging
import subprocess
app = Flask(__name__)

logging.basicConfig(level=logging.INFO)

@app.route('/run_command')
def run_command():
    app.logger.info(f"run_command: route called")
    
    received_cmd = request.json.get('cmd', '')

    app.logger.info(f"run_command: cmd to execute is\n\t{received_cmd}")

    ret = subprocess.run(received_cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    
    app.logger.info(f"run_command: done, return info is\n\t{ret}")
    
    if ret.returncode == 0:
        return jsonify({"output": ret.stdout.decode()})
    else:
        return jsonify({"output": ret.stdout.decode()}), 500

@app.route('/shutdown')
def shutdown():
    app.logger.info(f"shutdown route called")
    func = request.environ.get('werkzeug.server.shutdown')
    if func is None:
        raise RuntimeError('Not running with the Werkzeug Server')
    func()

    return 'Server shutting down...'

if __name__ == '__main__':
    os.chdir("/openpose")
    app.run(port=5001)