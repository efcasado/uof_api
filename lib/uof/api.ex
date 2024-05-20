defmodule UOF.API do
  @moduledoc """
  Utilities used by the different APIs implemented by this client.
  """
  use Tesla, only: [:get, :post], docs: false

  plug(Tesla.Middleware.BaseUrl, Application.get_env(:uof_api, :base_url))

  plug(Tesla.Middleware.Headers, [
    {"accept", "application/xml"},
    {"content-type", "application/xml"},
    {"x-access-token", Application.get_env(:uof_api, :auth_token)}
  ])

  # plug(Tesla.Middleware.XML, convention: BadgerFish)
  plug(Tesla.Middleware.XML, engine: Saxy)

  # https://docs.betradar.com/display/BD/UOF+-+Language+Support
  @supported_languages [
    # Albanian
    "sqi",
    # Amharic
    "am",
    # Arabic
    "aa",
    # Azerbaijan
    "aze",
    # Bosnian
    "bs",
    # Brazilian Portuguese
    "br",
    # Bulgarian
    "bg",
    # Burmese
    "my",
    # Chinese (simplified)
    "zh",
    # Chinese (traditional)
    "zht",
    # Croation
    "hr",
    # Czech
    "cs",
    # Danish
    "da",
    # Dutch
    "nl",
    # English
    "en",
    # Estonian
    "et",
    # Finnish
    "fi",
    # French
    "fr",
    # Georgian
    "ka",
    # German
    "de",
    # Greek
    "el",
    # Hebrew
    "heb",
    # Hindi
    "hi",
    # Hungarian
    "hu",
    # Indonesian
    "Id",
    # Italian
    "it",
    # Japanese
    "ja",
    # Kazakh
    "kaz",
    # Khmer
    "km",
    # Korean
    "ko",
    # Latvian
    "lv",
    # Lithuanian
    "lt",
    # Macedonian
    "ml",
    # Macedonian Cyrillic
    "mk",
    # Malay
    "ms",
    # Norwegian
    "no",
    # Persian/Farsi
    "fa",
    # Polish
    "pl",
    # Portuguese
    "pt",
    # Romanian
    "ro",
    # Russian
    "ru",
    # Serbian
    "sr",
    # Serbian Latin
    "srl",
    # Slovak
    "sk",
    # Slovenian
    "sl",
    # Spanish
    "es",
    # Swahili
    "sw",
    # Swedish
    "se",
    # Thai
    "th",
    # Turkish
    "tr",
    # Ukrainian
    "ukr",
    # Vietnamese
    "vi"
  ]
end
