module service

import domain.config.interfaces as conf
import net.http

pub struct BackendBabyDi {
pub:
	conf conf.IConfig
}

const endpoint_contain_user = '/user/contain'
const endpoint_contain_profile = '/profile/contain'

fn (bk_babydi &BackendBabyDi) contain_user(uuid string) !bool {
	api := bk_babydi.conf.get_backend_babydi()!

	endpoint := '${api}${service.endpoint_contain_user}/${uuid}'

	res := http.get(endpoint)!

	return if res.status_code != 200 {
		false
	} else {
		true
	}
}

fn (bk_babydi &BackendBabyDi) contain_profile(uuid string) !bool {
	api := bk_babydi.conf.get_backend_babydi()!

	endpoint := '${api}${service.endpoint_contain_profile}/${uuid}'

	res := http.get(endpoint)!

	return if res.status_code != 200 {
		false
	} else {
		true
	}
}
