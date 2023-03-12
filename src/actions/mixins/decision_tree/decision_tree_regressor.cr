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

    def class_counts(rows : Array(Array)) : Hash(String, Int32)
      # Create an empty hash to store the counts of each label
      counts = {} of String => Int32

      # Iterate through each row in the input array
      rows.each do |row|
        # Extract the label from the last element of the row
        label = row.last

        # If the label has not been seen before, initialize its count to 0
        unless counts[label]?
          counts[label] = 0
        end

        # Increment the count of the label
        counts[label] += 1
      end

      # Return the counts hash
      return counts
    end

    def partition(rows : Array(ArString | Int32 | Float64ray), question : Question) : Tuple(Array(Array), Array(Array))
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

    def gini(rows : Array(Array)) : Float64
      # Get the counts of each class label in the dataset
      counts = class_counts(rows)

      # Calculate the impurity using the Gini index formula
      impurity = 1.0
      counts.each do |lbl, count|
        prob_of_lbl = count / rows.size.to_f
        impurity -= prob_of_lbl**2
      end

      return impurity
    end
  end
end
