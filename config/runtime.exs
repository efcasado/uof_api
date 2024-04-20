import Config

config :uof_api, base_url: System.fetch_env!("UOF_BASE_URL")
config :uof_api, auth_token: System.fetch_env!("UOF_AUTH_TOKEN")
