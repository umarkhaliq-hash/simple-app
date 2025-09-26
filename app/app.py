import os
from flask import Flask, jsonify, request

app = Flask(__name__)

APP_NAME = os.getenv("APP_NAME", "devops-screener")
APP_ENV = os.getenv("APP_ENV", "local")
APP_VERSION = "1.0.0"

@app.get("/health")
def health():
    return jsonify(status="ok", app=APP_NAME, env=APP_ENV, version=APP_VERSION), 200

@app.get("/")
def index():
    name = request.args.get("name", "world")
    return jsonify(message=f"Hello, {name}!", app=APP_NAME, env=APP_ENV), 200

@app.get("/config")
def config():
    # Helpful for checking env injection in containers
    return jsonify(
        env=APP_ENV,
        app=APP_NAME,
        python_version=os.sys.version.split()[0]
    ), 200

if __name__ == "__main__":
    # Bind to 0.0.0.0 so it’s reachable in containers
    port = int(os.getenv("PORT", "5000"))
    app.run(host="0.0.0.0", port=port)
