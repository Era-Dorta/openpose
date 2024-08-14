from flask import Flask, request, jsonify
import os

app = Flask(__name__)

@app.route('/run_command')
def run_command():
    print("------- in Run command -------")
    print(f"------- request{request}")
    data = request.json
    received_cmd = data.get('cmd', '')
    print(f"-------  got cmd {received_cmd}")

    os.system(received_cmd)

    print("------- run command done -------")
    processed_message = "Processed"

    return jsonify({"output": processed_message})

if __name__ == '__main__':
    app.run(port=5001)