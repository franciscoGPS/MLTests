module DecisionTree
  class ColumnNotFoundException < Exception; end

  class WrongTargetFeatureSize < Exception; end

  class Regressor
    property df : Crysda::DataFrame
    property x_cols : Array(String)
    property y_col : Array(String)

    def initialize(@df, @x_cols, @y_col)
      (x_cols + y_col).map { |col| raise ColumnNotFoundException.new("#{x_cols}") unless @df.cols.includes?(col) }

      raise WrongTargetFeatureSize.new unless y_col.size == 1

      

      pp "in the regressor module"
    end

    def x_vector
      df.select(@x_cols)
    end

    def y_vector
      df.select(@y_col)
    end

    def unique_vals(rows : Array(Array(String | Int32 | Float64)), col : Int32) : Set(String)
      # Find the unique values for a column in a dataset
      rows.map { |row| row[col].to_s }.to_set
    end

    def class_counts(cols : Array(String) = [] of String) : Hash(String, Hash(String, Int32))
      # Create an empty hash to store the counts of each label
      counts = Hash(String, Hash(String, Int32)).new
      
      cols = df.names if cols.empty?


      # Iterate through each row in the input array
      cols.each do |col|
        counts[col] = tally(df[col].values)
      end
      counts
    end

    def tally(enumerable : Enumerable)
      enumerable.each_with_object(Hash(String, Int32).new(0)) do |elem, counts|
        counts[elem.to_s] += 1
      end
    end

    def partition(rows : Array(String | Int32 | Float64), question : Question) : Tuple(Array(Array), Array(Array))
      # Create empty arrays for the true and false rows
      true_rows = [] of Array
      false_rows = [] of Array

      # Iterate through each row in the input array
      rows.each do |row|
        # Check if the row matches the question
        if question.match(row)
          # If it does, add it to the true_rows array
          true_rows << row
        else
          # Otherwise, add it to the false_rows array
          false_rows << row
        end
      end

      # Return a tuple containing the true and false rows arrays
      return [true_rows, false_rows]
    end

    def gini : Float64
      # Get the counts of each class label in the dataset
      counts = class_counts(["Price"])

      # Calculate the impurity using the Gini index formula
      rows = 
      impurity = 1.0
      counts.each do |lbl, count|
        prob_of_lbl = count / rows.size.to_f
        impurity -= prob_of_lbl**2
      end

      return impurity
    end
  end
end
