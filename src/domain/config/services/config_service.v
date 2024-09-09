module services

import ken0x0a.dotenv

pub struct ConfigService {}

fn (_ &ConfigService) get_work_dir() !string {
	mut babydi_path_files := $env('BABYDI_PATH_FILES')
	$if dev ? {
		local_env := dotenv.parse('.env.local')

		babydi_path_files = local_env['BABYDI_PATH_FILES'] or {
			return error('Env var BABYDI_PATH_FILES not found')
		}
	}

	return babydi_path_files
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

		'${backend_host}:${backend_port}'
	} $else {
		backend_host := $env('BABYDI_BACKEND_HOST')
		backend_port := $env('BABYDI_BACKEND_PORT').int()

		'${backend_host}:${backend_port}'
	}
}
