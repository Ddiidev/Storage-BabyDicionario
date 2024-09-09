module services

import infra.backend_babydi.repository.service

pub struct BackendBabyDiService {}

fn (_ BackendBabyDiService) contain_user(uuid string) bool {
	backend := service.get()

	return backend.contain_user(uuid)
}

fn (_ BackendBabyDiService) contain_profile(uuid string) bool {
	backend := service.get()

	return backend.contain_profile(uuid)
}
