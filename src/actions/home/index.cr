import mxnet as mx
class Home::Index < BrowserAction
  
  get "/" do
    a = mx.ndarray.array([[1, 2], [3, 4]])
    b = mx.ndarray.array([1, 0])
    print(a * b)
    html Home::IndexPage
  end
end
