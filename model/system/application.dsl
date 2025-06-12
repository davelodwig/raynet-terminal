
glosnet = softwareSystem "GlosNET Terminal" {
	
	local = group "Local Service" {
		local_nginx = container "reverse proxy"
		local_ui = container "Front End" "Vue" {
			tags "frontend"
		}
		local_api = container "Local Service" "Python FastAPI"
		db_local = container "Local Database" {
			tags "database"
		}
	}
	
	global = group "Global Service" {
		global_nginx = container "global reverse proxy"
		global_ui = container "Global UI" "Vue"
		global_api = container "Global Service" "Python FastAPI"
		db_global = container "Global Database" {
			tags "database"
		}
	}
	
	queues = group "AMQP Queues" {
		q_inbound_messages = container "Inbound Message" "AMQP Queue" {
			tags "queue"
		}
		q_inbound_logmessages = container "Inbound Logbook" "AMQP Queue"{
			tags "queue"
		}
		q_outbound_messages_callsign = container "Outbound Message" "AMQP Queue" {
			tags "queue"
		}
		q_outbound_global_sync = container "Outbound Global Sync" "AMQP Queue" {
			tags "queue"
		}
		q_inbound_global_sync = container "Inbound Global Sync" "AMQP Queue" {
			tags "queue"
		}
	}
	
	local_nginx -> local_ui
	local_ui -> local_api "Receives Data From" "WebSocket"
	local_nginx -> local_api
	global_nginx -> global_api
	global_nginx -> global_ui
	
	local_api -> q_inbound_messages
	local_api -> q_inbound_logmessages
	q_outbound_messages_callsign -> local_api
	
	q_inbound_logmessages -> global_api
	q_inbound_messages -> global_api
	global_api -> q_outbound_messages_callsign
	
	local_api -> db_local
	global_api -> db_global
	
	
	
}

user -> local_nginx "Uses"
admin -> global_nginx "Accesses administration functions"