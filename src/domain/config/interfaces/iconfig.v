module interfaces

pub interface IConfig {
	get_work_dir() !string
	get_backend_babydi() !string
}
