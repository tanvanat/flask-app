from pydantic_settings import BaseSettings, SettingsConfigDict

class Settings(BaseSettings):
    service_name: str = "flask-api"
    default_greeter: str = "World"
    host: str = "0.0.0.0"
    port: int = 8000
    workers: int = 2
    log_level: str = "info"

    model_config = SettingsConfigDict(env_file=".env", env_prefix="APP_")

settings = Settings()
