# Database models and queries for CS admin panel

# Table definitions with searchable columns and select fields
TABLE_CONFIGS = {
    'cs_api': {
        'select_fields': ['id', 'app_api', 'status', 'createdAt', 'modifiedAt', 'createdBy', 'modifiedBy', 'deleted'],
        'search_fields': ['id', 'app_api', 'status', 'createdBy', 'modifiedBy'],
        'table_name': 'cs_api'
    },
    'cs_api_application_master': {
        'select_fields': ['id', 'env_id', 'env_name', 'type', 'status', 'createdAt', 'modifiedAt', 'createdBy', 'modifiedBy', 'deleted'],
        'search_fields': ['id', 'env_id', 'env_name', 'type', 'status', 'createdBy', 'modifiedBy'],
        'table_name': 'cs_api_application_master'
    },
    'cs_api_log': {
        'select_fields': ['id', 'env_id', 'api_name', 'url', 'method', 'request_body', 'req_header', 'response', 'status', 'ip', 'created_date', 'createdAt', 'modifiedAt', 'deleted'],
        'search_fields': ['id', 'env_id', 'api_name', 'url', 'method', 'status', 'ip'],
        'table_name': 'cs_api_log'
    },
    'cs_application': {
        'select_fields': ['id', 'env_id', 'client_id', 'env_name', 'code', 'app_api_config', 'status', 'retry_attempts', 'createdAt', 'modifiedAt', 'createdBy', 'modifiedBy', 'deleted'],
        'search_fields': ['id', 'env_id', 'env_name', 'code', 'status'],
        'table_name': 'cs_application'
    },
    'cs_client': {
        'select_fields': ['id', 'client_name', 'status', 'createdAt', 'modifiedAt', 'createdBy', 'modifiedBy', 'deleted'],
        'search_fields': ['id', 'client_name', 'status', 'createdBy', 'modifiedBy'],
        'table_name': 'cs_client'
    },
    'cs_comm_queue': {
        'select_fields': ['id', 'env_id', 'comm_id', 'ref_id', 'module', 'sender_id', 'type', 'subject', 'body', '`to`', 'cc', 'var_data', 'attachments', 'status', 'attempts', 'attempts_left', 'createdAt', 'modifiedAt'],
        'search_fields': ['id', 'env_id', 'ref_id', 'sender_id', 'type', 'subject', 'to', 'status'],
        'table_name': 'cs_comm_queue'
    },
    'cs_communication': {
        'select_fields': ['id', 'env_id', 'ref_id', 'module', 'sender_id', 'type', 'subject', 'body', '`to`', 'attachments', 'cc', 'status', 'createdAt', 'modifiedAt'],
        'search_fields': ['id', 'env_id', 'ref_id', 'sender_id', 'type', 'subject', 'to', 'status'],
        'table_name': 'cs_communication'
    },
    'cs_sms_config': {
        'select_fields': ['id', 'env_id', 'sender_username', 'sender_password', 'sender', 'license_code', 'auth_token', 'base_api_url', 'type', 'status', 'createdAt', 'modifiedAt', 'createdBy', 'modifiedBy', 'deleted'],
        'search_fields': ['id', 'env_id', 'sender_username', 'sender', 'license_code', 'type', 'status'],
        'table_name': 'cs_sms_config'
    },
    'cs_smtp_config': {
        'select_fields': ['id', 'env_id', 'mail_host', 'mail_port', 'sender_email', 'mail_username', 'mail_password', 'status', 'createdAt', 'modifiedAt', 'createdBy', 'modifiedBy', 'deleted'],
        'search_fields': ['env_id', 'mail_host', 'sender_email', 'mail_username', 'status'],
        'table_name': 'cs_smtp_config'
    },
    'cs_user': {
        'select_fields': ['id', 'id_str', 'role_id', 'username', 'first_name', 'middle_name', 'last_name', 'email', 'mobile', 'status', 'is_admin', 'web_access', 'mobile_access', 'last_password_change', 'modified', 'created_by', 'modified_by', 'deleted'],
        'search_fields': ['id', 'username', 'first_name', 'last_name', 'email', 'mobile', 'status', 'is_admin'],
        'table_name': 'cs_user'
    },
    'cs_whatsapp_config': {
        'select_fields': ['id', 'env_id', 'whatsapp_phone_number_id', 'whatsapp_access_token', 'sender', 'whatsapp_vendor_id', 'type', 'status', 'createdAt', 'modifiedAt', 'createdBy', 'modifiedBy', 'deleted'],
        'search_fields': ['id', 'env_id', 'sender', 'type', 'status'],
        'table_name': 'cs_whatsapp_config'
    }
}

# SQL Queries
class AdminQueries:
    
    @staticmethod
    def get_list_query(table_name, search_params=None):
        """
        Generate list query with optional search parameters
        """
        config = TABLE_CONFIGS.get(table_name)
        if not config:
            raise ValueError(f"Table {table_name} not configured")
        
        select_fields = ', '.join(config['select_fields'])
        base_query = f"SELECT {select_fields} FROM {table_name}"
        
        where_conditions = []
        params = []
        
        # Add deleted filter for tables that have it
        if table_name != 'cs_api_log' and table_name != 'cs_communication' and table_name != 'cs_comm_queue':
            where_conditions.append("deleted = 0")
        
        # Add search conditions
        if search_params:
            for field, value in search_params.items():
                if field in config['search_fields'] and value:
                    where_conditions.append(f"{field} LIKE %s")
                    params.append(f"%{value}%")
        
        if where_conditions:
            base_query += " WHERE " + " AND ".join(where_conditions)
        
        return base_query, params
    
    @staticmethod
    def get_count_query(table_name, search_params=None):
        """
        Generate count query with optional search parameters
        """
        config = TABLE_CONFIGS.get(table_name)
        if not config:
            raise ValueError(f"Table {table_name} not configured")
        
        base_query = f"SELECT COUNT(*) as total FROM {table_name}"
        
        where_conditions = []
        params = []
        
        # Add deleted filter for tables that have it
        if table_name != 'cs_api_log' and table_name != 'cs_communication' and table_name != 'cs_comm_queue':
            where_conditions.append("deleted = 0")
        
        # Add search conditions
        if search_params:
            for field, value in search_params.items():
                if field in config['search_fields'] and value:
                    where_conditions.append(f"{field} LIKE %s")
                    params.append(f"%{value}%")
        
        if where_conditions:
            base_query += " WHERE " + " AND ".join(where_conditions)
        
        return base_query, params
    
    @staticmethod
    def get_details_query(table_name):
        """
        Generate details query for a specific record
        """
        config = TABLE_CONFIGS.get(table_name)
        if not config:
            raise ValueError(f"Table {table_name} not configured")
        
        # For details, select all fields
        query = f"SELECT * FROM {table_name} WHERE id = %s"
        
        # Add deleted filter for tables that have it
        if table_name != 'cs_api_log' and table_name != 'cs_communication' and table_name != 'cs_comm_queue':
            query += " AND deleted = 0"
        
        return query

# Search field configurations for frontend
SEARCH_FIELD_CONFIGS = {
    'cs_api': [
        {'field': 'id', 'label': 'ID', 'type': 'text'},
        {'field': 'app_api', 'label': 'App API', 'type': 'text'},
        {'field': 'status', 'label': 'Status', 'type': 'select', 'options': ['active', 'inactive']},
        {'field': 'createdBy', 'label': 'Created By', 'type': 'text'},
        {'field': 'modifiedBy', 'label': 'Modified By', 'type': 'text'}
    ],
    'cs_api_application_master': [
        {'field': 'id', 'label': 'ID', 'type': 'text'},
        {'field': 'env_id', 'label': 'Environment ID', 'type': 'text'},
        {'field': 'env_name', 'label': 'Environment Name', 'type': 'text'},
        {'field': 'type', 'label': 'Type', 'type': 'select', 'options': ['sms', 'email', 'whatsapp']},
        {'field': 'status', 'label': 'Status', 'type': 'select', 'options': ['active', 'inactive']}
    ],
    'cs_api_log': [
        {'field': 'id', 'label': 'ID', 'type': 'text'},
        {'field': 'env_id', 'label': 'Environment ID', 'type': 'text'},
        {'field': 'api_name', 'label': 'API Name', 'type': 'text'},
        {'field': 'url', 'label': 'URL', 'type': 'text'},
        {'field': 'method', 'label': 'Method', 'type': 'text'},
        {'field': 'status', 'label': 'Status', 'type': 'select', 'options': ['Requested', 'Failed', 'Success']},
        {'field': 'ip', 'label': 'IP Address', 'type': 'text'}
    ],
    'cs_application': [
        {'field': 'id', 'label': 'ID', 'type': 'text'},
        {'field': 'env_id', 'label': 'Environment ID', 'type': 'text'},
        {'field': 'env_name', 'label': 'Environment Name', 'type': 'text'},
        {'field': 'code', 'label': 'Code', 'type': 'text'},
        {'field': 'status', 'label': 'Status', 'type': 'select', 'options': ['active', 'inactive']}
    ],
    'cs_client': [
        {'field': 'id', 'label': 'ID', 'type': 'text'},
        {'field': 'client_name', 'label': 'Client Name', 'type': 'text'},
        {'field': 'status', 'label': 'Status', 'type': 'select', 'options': ['active', 'inactive']}
    ],
    'cs_comm_queue': [
        {'field': 'id', 'label': 'ID', 'type': 'text'},
        {'field': 'env_id', 'label': 'Environment ID', 'type': 'text'},
        {'field': 'ref_id', 'label': 'Reference ID', 'type': 'text'},
        {'field': 'sender_id', 'label': 'Sender ID', 'type': 'text'},
        {'field': 'type', 'label': 'Type', 'type': 'select', 'options': ['email', 'sms']},
        {'field': 'subject', 'label': 'Subject', 'type': 'text'},
        {'field': 'to', 'label': 'To', 'type': 'text'},
        {'field': 'status', 'label': 'Status', 'type': 'select', 'options': ['open', 'processed', 'failed']}
    ],
    'cs_communication': [
        {'field': 'id', 'label': 'ID', 'type': 'text'},
        {'field': 'env_id', 'label': 'Environment ID', 'type': 'text'},
        {'field': 'ref_id', 'label': 'Reference ID', 'type': 'text'},
        {'field': 'sender_id', 'label': 'Sender ID', 'type': 'text'},
        {'field': 'type', 'label': 'Type', 'type': 'select', 'options': ['email', 'sms']},
        {'field': 'subject', 'label': 'Subject', 'type': 'text'},
        {'field': 'to', 'label': 'To', 'type': 'text'},
        {'field': 'status', 'label': 'Status', 'type': 'select', 'options': ['pending', 'send', 'delivered', 'failed']}
    ],
    'cs_sms_config': [
        {'field': 'id', 'label': 'ID', 'type': 'text'},
        {'field': 'env_id', 'label': 'Environment ID', 'type': 'text'},
        {'field': 'sender_username', 'label': 'Sender Username', 'type': 'text'},
        {'field': 'sender', 'label': 'Sender', 'type': 'text'},
        {'field': 'type', 'label': 'Type', 'type': 'text'},
        {'field': 'status', 'label': 'Status', 'type': 'select', 'options': ['active', 'inactive']}
    ],
    'cs_smtp_config': [
        {'field': 'id', 'label': 'ID', 'type': 'text'},
        {'field': 'env_id', 'label': 'Environment ID', 'type': 'text'},
        {'field': 'mail_host', 'label': 'Mail Host', 'type': 'text'},
        {'field': 'sender_email', 'label': 'Sender Email', 'type': 'text'},
        {'field': 'mail_username', 'label': 'Mail Username', 'type': 'text'},
        {'field': 'status', 'label': 'Status', 'type': 'select', 'options': ['active', 'inactive']}
    ],
    'cs_user': [
        {'field': 'id', 'label': 'ID', 'type': 'text'},
        {'field': 'username', 'label': 'Username', 'type': 'text'},
        {'field': 'first_name', 'label': 'First Name', 'type': 'text'},
        {'field': 'last_name', 'label': 'Last Name', 'type': 'text'},
        {'field': 'email', 'label': 'Email', 'type': 'text'},
        {'field': 'mobile', 'label': 'Mobile', 'type': 'text'},
        {'field': 'status', 'label': 'Status', 'type': 'select', 'options': ['active', 'inactive', 'dormant']},
        {'field': 'is_admin', 'label': 'Is Admin', 'type': 'select', 'options': ['on', 'off']}
    ],
    'cs_whatsapp_config': [
        {'field': 'id', 'label': 'ID', 'type': 'text'},
        {'field': 'env_id', 'label': 'Environment ID', 'type': 'text'},
        {'field': 'sender', 'label': 'Sender', 'type': 'text'},
        {'field': 'type', 'label': 'Type', 'type': 'text'},
        {'field': 'status', 'label': 'Status', 'type': 'select', 'options': ['active', 'inactive']}
    ]
}