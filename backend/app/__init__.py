import os
from flask import Flask, request, jsonify
from flask_jwt_extended import JWTManager
from app.database import init_db_pool
from flask_cors import CORS

from app.admin.routes import admin_bp

app = Flask(__name__)

CORS(app)

app.config["JWT_SECRET_KEY"] = os.getenv("JWT_SECRET_KEY")
app.config["JWT_ALGORITHM"] = os.getenv("JWT_ALGORITHM", "HS256")
jwt = JWTManager(app)

with app.app_context():
    init_db_pool(pool_size=10)

# Register the blueprints
app.register_blueprint(admin_bp, url_prefix='/admin')