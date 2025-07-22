workspace "GlosNET Terminal" "A low latency, radio logging and messaging solution" {
	
	!docs docs
	
	!adrs adrs
	
	model {
		
		# Personas
		!include model/persona/personas.dsl
		
		# Systems
		!include model/system/external.dsl
		!include model/system/application.dsl
		
		# Deployments
		!include model/deployment/production.dsl
		
	}
	
	views {
		
		systemLandscape "SystemLandscape" {
			include *
			autolayout lr
		}
		
		systemContext glosnet {
			include *
			autolayout lr
		}
		
		container glosnet {
			include *
			autolayout lr
		}
		
		deployment * production {
			include *
			autolayout lr
		}
		
		styles {
			
			element "frontend" {
				shape WebBrowser
			}
			
			element "microservice" {
				shape Hexagon
			}
			
			element "database" {
				shape Cylinder
			}
			
			element "queue" {
				shape Pipe
			}
			
		}
		
		themes default https://static.structurizr.com/themes/amazon-web-services-2023.01.31/theme.json https://static.structurizr.com/themes/kubernetes-v0.3/theme.json
		
	}
	
}