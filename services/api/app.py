from flask import Flask, request
from config.settings import settings
from libs.common.utils import greet

def create_app() -> Flask:
    app = Flask(__name__)
    app.config["SERVICE_NAME"] = settings.service_name

    @app.get("/")
    def index():
        return f"Service {app.config['SERVICE_NAME']} is running OK"

    @app.get("/healthz")
    def healthz():
        return "ok"

    @app.route("/greet", methods=["GET", "POST"])
    def greet_ep():
        if request.method == "POST":
            name = request.form.get("name") or settings.default_greeter
            return f"<h2>{greet(name)}</h2><br><a href='/greet'>Back</a>"
        # Show a simple input form when GET
        return """
        <form method="post">
            <label>Enter your name: </label>
            <input type="text" name="name">
            <input type="submit" value="Greet me!">
        </form>
        """

    return app

app = create_app()
