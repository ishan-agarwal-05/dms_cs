from flask import Blueprint, jsonify, request
from flask_jwt_extended import jwt_required
from app.admin.services import (
    admin_login_service,
    get_request_data,
    get_api_list_service,
    get_api_details_service,
    get_api_application_master_list_service,
    get_api_application_master_details_service,
    get_api_logs_list_service,
    get_api_logs_details_service,
    get_application_list_service,
    get_application_details_service,
    get_client_list_service,
    get_client_details_service,
    get_comm_queue_list_service,
    get_comm_queue_details_service,
    get_communication_list_service,
    get_communication_details_service,
    get_sms_config_list_service,
    get_sms_config_details_service,
    get_smtp_config_list_service,
    get_smtp_config_details_service,
    get_users_list_service,
    get_users_details_service,
    get_whatsapp_config_list_service,
    get_whatsapp_config_details_service
)

admin_bp = Blueprint('admin_routes', __name__)

def list_route_wrapper(service_function):
    request_data, error_response, status_code = get_request_data()
    if error_response:
        return jsonify(error_response), status_code
    return service_function(request_data)

def details_route_wrapper(service_function):
    data = request.get_json()
    response, status_code = service_function(data)
    return response, status_code

# Login endpoint (not JWT protected)
@admin_bp.route('/login', methods=['POST'])
def admin_login():
    data = request.get_json()
    response, status_code = admin_login_service(data)
    return response, status_code

# --- API Endpoints ---
@admin_bp.route('/api/list', methods=['POST'])
@jwt_required()
def admin_api_list():
    return list_route_wrapper(get_api_list_service)

@admin_bp.route('/api/details', methods=['POST'])
@jwt_required()
def admin_api_details():
    return details_route_wrapper(get_api_details_service)

# --- API Application Master Endpoints ---
@admin_bp.route('/api_application_master/list', methods=['POST'])
@jwt_required()
def admin_api_application_master_list():
    return list_route_wrapper(get_api_application_master_list_service)

@admin_bp.route('/api_application_master/details', methods=['POST'])
@jwt_required()
def admin_api_application_master_details():
    return details_route_wrapper(get_api_application_master_details_service)

# --- API Logs Endpoints ---
@admin_bp.route('/api_logs/list', methods=['POST'])
@jwt_required()
def admin_api_logs_list():
    return list_route_wrapper(get_api_logs_list_service)

@admin_bp.route('/api_logs/details', methods=['POST'])
@jwt_required()
def admin_api_logs_details():
    return details_route_wrapper(get_api_logs_details_service)

# --- Application Endpoints ---
@admin_bp.route('/application/list', methods=['POST'])
@jwt_required()
def admin_application_list():
    return list_route_wrapper(get_application_list_service)

@admin_bp.route('/application/details', methods=['POST'])
@jwt_required()
def admin_application_details():
    return details_route_wrapper(get_application_details_service)

# --- Client Endpoints ---
@admin_bp.route('/client/list', methods=['POST'])
@jwt_required()
def admin_client_list():
    return list_route_wrapper(get_client_list_service)

@admin_bp.route('/client/details', methods=['POST'])
@jwt_required()
def admin_client_details():
    return details_route_wrapper(get_client_details_service)

# --- Communication Queue Endpoints ---
@admin_bp.route('/comm_queue/list', methods=['POST'])
@jwt_required()
def admin_comm_queue_list():
    return list_route_wrapper(get_comm_queue_list_service)

@admin_bp.route('/comm_queue/details', methods=['POST'])
@jwt_required()
def admin_comm_queue_details():
    return details_route_wrapper(get_comm_queue_details_service)

# --- Communication Endpoints ---
@admin_bp.route('/communication/list', methods=['POST'])
@jwt_required()
def admin_communication_list():
    return list_route_wrapper(get_communication_list_service)

@admin_bp.route('/communication/details', methods=['POST'])
@jwt_required()
def admin_communication_details():
    return details_route_wrapper(get_communication_details_service)

# --- SMS Config Endpoints ---
@admin_bp.route('/sms_config/list', methods=['POST'])
@jwt_required()
def admin_sms_config_list():
    return list_route_wrapper(get_sms_config_list_service)

@admin_bp.route('/sms_config/details', methods=['POST'])
@jwt_required()
def admin_sms_config_details():
    return details_route_wrapper(get_sms_config_details_service)

# --- SMTP Config Endpoints ---
@admin_bp.route('/smtp_config/list', methods=['POST'])
@jwt_required()
def admin_smtp_config_list():
    return list_route_wrapper(get_smtp_config_list_service)

@admin_bp.route('/smtp_config/details', methods=['POST'])
@jwt_required()
def admin_smtp_config_details():
    return details_route_wrapper(get_smtp_config_details_service)

# --- Users Endpoints ---
@admin_bp.route('/users/list', methods=['POST'])
@jwt_required()
def admin_users_list():
    return list_route_wrapper(get_users_list_service)

@admin_bp.route('/users/details', methods=['POST'])
@jwt_required()
def admin_users_details():
    return details_route_wrapper(get_users_details_service)

# --- WhatsApp Config Endpoints ---
@admin_bp.route('/whatsapp_config/list', methods=['POST'])
@jwt_required()
def admin_whatsapp_config_list():
    return list_route_wrapper(get_whatsapp_config_list_service)

@admin_bp.route('/whatsapp_config/details', methods=['POST'])
@jwt_required()
def admin_whatsapp_config_details():
    return details_route_wrapper(get_whatsapp_config_details_service)