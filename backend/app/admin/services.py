from app.database import get_db_connection, close_db_connection
from flask import jsonify, request
from mysql.connector import Error
from typing import Union, List, Tuple, Optional
import json
import bcrypt
import os
from flask_jwt_extended import create_access_token
from app.admin.models import AdminQueries, TABLE_CONFIGS, SEARCH_FIELD_CONFIGS

def get_entity_details(data, id_field, table_name, not_found_message="Entity not found"):
    """
    Generic function to fetch entity details from database
    
    Args:
        data (dict): Request data containing the ID
        id_field (str): The name of the ID field in the request data
        table_name (str): Database table to query
        not_found_message (str): Custom message for when entity isn't found
        
    Returns:
        tuple: (response, status_code)
    """
    if not data or id_field not in data:
        return jsonify({'message': f'{id_field} is required in request body'}), 400

    conn = get_db_connection()
    if not conn:
        return jsonify({"error": "Database connection failed"}), 500
        
    cursor = conn.cursor(dictionary=True)
    
    try:
        query = AdminQueries.get_details_query(table_name)
        cursor.execute(query, (data[id_field],))
        entity = cursor.fetchone()
        
        if entity:
            return jsonify(entity), 200
        else:
            return jsonify({'message': not_found_message}), 404
            
    except Error as e:
        return jsonify({"error": f"Database error: {str(e)}"}), 500
    finally:
        close_db_connection(conn, cursor)

def get_entity_list(request_data, table_name):
    """
    Generic function to get paginated list of entities with column-specific search
    
    Args:
        request_data (dict): Request data with pagination and search params
        table_name (str): Database table to query
        
    Returns:
        tuple: (response, status_code)
    """
    try:
        page = request_data.get('page', 1)
        limit = request_data.get('limit', 10)
        search_params = request_data.get('search', {})
        
        offset = (page - 1) * limit
        
        conn = get_db_connection()
        if not conn:
            return jsonify({"error": "Database connection failed"}), 500
            
        cursor = conn.cursor(dictionary=True)
        
        # Get count query and parameters
        count_query, count_params = AdminQueries.get_count_query(table_name, search_params)
        cursor.execute(count_query, count_params)
        total_count = cursor.fetchone()['total']
        
        # Get list query and parameters
        list_query, list_params = AdminQueries.get_list_query(table_name, search_params)
        list_query += " ORDER BY id DESC LIMIT %s OFFSET %s"
        cursor.execute(list_query, list_params + [limit, offset])
        entities = cursor.fetchall()
        
        close_db_connection(conn, cursor)
        
        return jsonify({
            "data": entities,
            "totalItems": total_count,
            "totalPages": (total_count + limit - 1) // limit,
            "currentPage": page,
            "itemsPerPage": limit,
            "search_fields": SEARCH_FIELD_CONFIGS.get(table_name, [])
        }), 200
        
    except Error as e:
        return jsonify({"error": f"Database error: {str(e)}"}), 500

# Admin login function
def admin_login_service(data):
    """
    Admin login service
    """
    if not data or 'username' not in data or 'password' not in data:
        return jsonify({'message': 'Username and password are required'}), 400
    
    username = data['username']
    password = data['password']
    
    conn = get_db_connection()
    if not conn:
        return jsonify({"error": "Database connection failed"}), 500
        
    cursor = conn.cursor(dictionary=True)
    
    try:
        cursor.execute("SELECT * FROM cs_user WHERE username = %s AND is_admin = 'on' AND status = 'active'", (username,))
        user = cursor.fetchone()
        
        if user and bcrypt.checkpw(password.encode('utf-8'), user['password'].encode('utf-8')):
            access_token = create_access_token(identity=user['id'])
            return jsonify({
                'message': 'Login successful',
                'access_token': access_token,
                'user': {
                    'id': user['id'],
                    'username': user['username'],
                    'first_name': user['first_name'],
                    'last_name': user['last_name']
                }
            }), 200
        else:
            return jsonify({'message': 'Invalid credentials'}), 401
            
    except Error as e:
        return jsonify({"error": f"Database error: {str(e)}"}), 500
    finally:
        close_db_connection(conn, cursor)

# Specific service functions for each table
def get_api_list_service(request_data):
    return get_entity_list(request_data, 'cs_api')

def get_api_details_service(data):
    return get_entity_details(data, 'api_id', 'cs_api', 'API not found')

def get_api_application_master_list_service(request_data):
    return get_entity_list(request_data, 'cs_api_application_master')

def get_api_application_master_details_service(data):
    return get_entity_details(data, 'api_application_master_id', 'cs_api_application_master', 'API Application Master not found')

def get_api_logs_list_service(request_data):
    return get_entity_list(request_data, 'cs_api_log')

def get_api_logs_details_service(data):
    return get_entity_details(data, 'api_log_id', 'cs_api_log', 'API Log not found')

def get_application_list_service(request_data):
    return get_entity_list(request_data, 'cs_application')

def get_application_details_service(data):
    return get_entity_details(data, 'application_id', 'cs_application', 'Application not found')

def get_client_list_service(request_data):
    return get_entity_list(request_data, 'cs_client')

def get_client_details_service(data):
    return get_entity_details(data, 'client_id', 'cs_client', 'Client not found')

def get_comm_queue_list_service(request_data):
    return get_entity_list(request_data, 'cs_comm_queue')

def get_comm_queue_details_service(data):
    return get_entity_details(data, 'comm_queue_id', 'cs_comm_queue', 'Communication Queue not found')

def get_communication_list_service(request_data):
    return get_entity_list(request_data, 'cs_communication')

def get_communication_details_service(data):
    return get_entity_details(data, 'communication_id', 'cs_communication', 'Communication not found')

def get_sms_config_list_service(request_data):
    return get_entity_list(request_data, 'cs_sms_config')

def get_sms_config_details_service(data):
    return get_entity_details(data, 'sms_config_id', 'cs_sms_config', 'SMS Config not found')

def get_smtp_config_list_service(request_data):
    return get_entity_list(request_data, 'cs_smtp_config')

def get_smtp_config_details_service(data):
    return get_entity_details(data, 'smtp_config_id', 'cs_smtp_config', 'SMTP Config not found')

def get_users_list_service(request_data):
    return get_entity_list(request_data, 'cs_user')

def get_users_details_service(data):
    return get_entity_details(data, 'user_id', 'cs_user', 'User not found')

def get_whatsapp_config_list_service(request_data):
    return get_entity_list(request_data, 'cs_whatsapp_config')

def get_whatsapp_config_details_service(data):
    return get_entity_details(data, 'whatsapp_config_id', 'cs_whatsapp_config', 'WhatsApp Config not found')

def get_request_data():
    """
    Extract and validate request data for list endpoints
    """
    try:
        data = request.get_json()
        if not data:
            return None, {"error": "No JSON data provided"}, 400
        return data, None, None
    except Exception as e:
        return None, {"error": f"Invalid JSON: {str(e)}"}, 400