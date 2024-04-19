# https://docs.betradar.com/display/BD/UOF+-+Competitors+profile
defmodule UOF.API.Jersey do
  @moduledoc """
  """
  import SweetXml

  defstruct type: "",
            base: "",
            sleeve: "",
            number: "",
            stripes: "",
            horizontal_stripes: "",
            squares: "",
            split: "",
            shirt_type: ""

  @type t :: %__MODULE__{
    type: String.t,
    base: String.t,
    sleeve: String.t,
    number: String.t,
    stripes: String.t,
    horizontal_stripes: String.t,
    squares: String.t,
    split: String.t,
    shirt_type: String.t,
  }

  def schema do
    [
      type: ~x"./@type"s,
      base: ~x"./@base"s,
      sleeve: ~x"./@sleeve"s,
      number: ~x"./@number"s,
      stripes: ~x"./@stripes"s,
      horizontal_stripes: ~x"./@horizontal_stripes"s,
      squares: ~x"./@squares"s,
      split: ~x"./@split"s,
      shirt_type: ~x"./@shirt_type"s
    ]
  end
end
