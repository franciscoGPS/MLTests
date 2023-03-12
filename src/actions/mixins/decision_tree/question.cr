module DecisionTree
  class Question
    # A Question is used to partition a dataset.
    # This class just records a 'column number' (e.g., 0 for Color) and a
    # 'column value' (e.g., Green). The 'match' method is used to compare
    # the feature value in an example to the feature value stored in the
    # question. See the demo below.

    property column : Int32
    property value : String

    def initialize(@column : Int32, @value : String)
    end

    def match(example : Array(String | Int32 | Float64)) : Bool
      # Compare the feature value in an example to the feature value in this question.
      val = example[column]
      if val.is_a?(Float64) || val.is_a?(Int32)
        val >= value.to_f64
      else
        val == value
      end
    end

    def to_s : String
      # This is just a helper method to print the question in a readable format.
      condition = "=="
      if value.is_a?(Float64) || value.is_a?(Int32)
        condition = ">="
      end
      "Is #{header[column]} #{condition} #{value}?"
    end
  end
end
