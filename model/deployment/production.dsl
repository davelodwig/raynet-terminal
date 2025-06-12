production = deploymentEnvironment "Production" {
	
	local_node_1 = deploymentNode "Local Terminal 1" {
		
		deploymentNode "Docker" {
			
			local_1_nginx = containerInstance local_nginx
			local_1_api = containerInstance local_api
			local_1_ui = containerInstance local_ui
			local_1_db = containerInstance db_local
			
			local_1_rabbit = infrastructureNode "AMQP Broker"
			local_1_api -> local_1_rabbit "AMQP Push"
			local_1_rabbit -> local_1_api "AMQP Pull"
		}
		
	}
	
	global_node_1 = deploymentNode "Nympsfield Compute Cluster" {
		
		global_1_rabbit = infrastructureNode "AMQP Broker"
		global_1_nginx = containerInstance global_nginx
		global_1_api = containerInstance global_api
		global_1_ui = containerInstance global_ui
		global_1_db = containerInstance db_global
		
		global_1_api -> global_1_rabbit "AMQP push"
		global_1_rabbit -> global_1_api "AMQP pull"
		
	}
	
	global_1_rabbit -> local_1_rabbit "AMQP Shovel"
}