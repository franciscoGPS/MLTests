class Home::Index < BrowserAction
  include DataAnalisys
  get "/" do
    filename = "cali_housing.csv"
    df = load(filename)
    
    x_vector = ["Longitude"]
    y_vector = ["MedHouseVal"]

    reg = DecisionTree::Regressor.new(df, x_vector, y_vector)
    reg.fit
    #######
    # Demo:
    # Let's look at some example to understand how Gini Impurity works.
    #
    # First, we'll look at a dataset with no mixing.

    # this will return 0.5 - meaning, there's a 50% chance of misclassifying
    # a random example we draw from the dataset.
    html Home::IndexPage
  end
end
