module service

import domain.config.services as config_service
import infra.backend_babydi.repository.interfaces
import infra.backend_babydi.repository.implementations

pub fn get() interfaces.IBackendBabyDi {
	return implementations.BackendBabyDi{
		conf: config_service.ConfigService{}
	}
}
