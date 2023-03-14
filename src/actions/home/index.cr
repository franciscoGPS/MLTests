class Home::Index < BrowserAction
  include DataAnalisys
  get "/" do
    filename = "melb_data.csv"
    df = load(filename)
    pp df.print
    x_vector = ["Rooms", "Bathroom", "Landsize", "Lattitude", "Longtitude"]
    y_vector = ["Price"]

    reg = DecisionTree::Regressor.new(df, x_vector, y_vector)
    pp reg

    #######
    # Demo:
    # Let's look at some example to understand how Gini Impurity works.
    #
    # First, we'll look at a dataset with no mixing.

    # this will return 0.5 - meaning, there's a 50% chance of misclassifying
    # a random example we draw from the dataset.
    pp reg.gini
    html Home::IndexPage
  end
end
