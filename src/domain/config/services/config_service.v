module services

import ken0x0a.dotenv

pub struct ConfigService {}

fn (_ &ConfigService) get_work_dir() !string {
	return $if dev ? {
		local_env := dotenv.parse('.env.local')

		babydi_path_files := local_env['BABYDI_PATH_FILES'] or {
			return error('Env var BABYDI_PATH_FILES not found')
		}

		babydi_path_files.trim_space()
	} $else {
		$env('BABYDI_PATH_FILES')
	}
}

fn (_ &ConfigService) get_backend_babydi() !string {
	return $if dev ? {
		local_env := dotenv.parse('.env.local')

		backend_host := local_env['BABYDI_BACKEND_HOST'] or {
			return error('Env var BABYDI_BACKEND_HOST not found')
		}
		backend_port := local_env['BABYDI_BACKEND_PORT'] or {
			return error('Env var BABYDI_BACKEND_PORT not found')
		}

		'${backend_host.trim_space()}:${backend_port.trim_space()}'
	} $else {
		backend_host := $env('BABYDI_BACKEND_HOST')
		backend_port := $env('BABYDI_BACKEND_PORT')

		'${backend_host.trim_space()}:${backend_port.trim_space()}'
	}
}
