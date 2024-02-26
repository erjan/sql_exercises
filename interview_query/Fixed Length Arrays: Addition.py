'''
Create an Array class simulating the functionality of fixed-size arrays. The array’s size is 6. The array’s constructor is already defined:

class Array:

    def __init__(self):
        pass  # Dynamically added to avoid tampering
        self._count = 0
        self._array = [None, None, None, None, None, None]
        self._MAX_CAPACITY = 6
There is no need to implement the constructor. In the code editor, __init__ will contain pass. The constructor’s code will be added dynamically to avoid any changes.

The Array class should have the following methods:

__len__(): Returns the length of the array. For example, if the array is [1, 2, None, None, None, None, None], __len__() will return 2.

__getitem__(index): Returns the element at the specified index. Raises an IndexError when the index is out of range.

emplace_back(element): Places an element at the back of the array. Raises an ArrayFull exception when the array is full (length > 6).

emplace_front(element): Places an element at the front of the array. Raises an ArrayFull exception when the array is full (length > 6).

emplace(element, index): Places an element at the specified index. Raises an ArrayFull exception when the array is full (length > 6).

Note: ArrayFull is already implemented. To raise it, simply use raise ArrayFull().
'''
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


class Array:

    def __init__(self):
        pass # Do not modify. Refer to the question for the actual implementation.
 
    
    def __len__(self):
        return self._count
        
    def __getitem__(self, index):
        if index > self._MAX_CAPACITY or index < 0:
            raise IndexError('Index out of range')
        
        return self._array[index]

    def emplace_back(self, element):
        if self._count >=self._MAX_CAPACITY:            
            raise ArrayFull()
        self._array[self._count] = element
        self._count+=1

    def emplace_front(self, element):
        if self._count >=self._MAX_CAPACITY:            
            raise ArrayFull()
        
        for i in range(self._count,0,-1):
            self._array[i] = self._array[i-1]
        self._array[0] = element
        self._count+=1

    def emplace(self, element, index):
        if self._count>= self._MAX_CAPACITY:
            raise ArrayFull()
        if index >self._count:
            raise IndexError('Index out of range')
        for i in range(self._count,index,-1):
            self._array[i] = self._array[i-1]
        self._array[index] = element
        self._count+=1
