import Config

# Phoenix endpoint configuration for development
config :kv_store, KvStoreWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false, # Disabling origin check for local development
  code_reloader: true, # Enable code reloading in development
  debug_errors: true, # Enable detailed error reports
  secret_key_base: "kSMgD6TQ6B9CSKrtybg5T2H5vrypRlxFf/5X9d1LL3/3VURmsAPnYjMkV3OPiN/j", # Secret key base for sessions
  watchers: [] # Disable external watchers for now

# LiveDashboard configuration
config :kv_store, KvStoreWeb.Endpoint,
  live_dashboard: [
    at: "/dashboard"  # URL to access the LiveDashboard
  ]

# Enable dev routes for the dashboard and mailbox
config :kv_store, dev_routes: true

# Logger configuration for development (simplified log format)
config :logger, :console,
  format: "[$level] $message\n",
  metadata: [:request_id]

# Configure Phoenix to show full stack traces in development
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime