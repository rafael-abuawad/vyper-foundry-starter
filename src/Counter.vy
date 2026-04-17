# pragma version ~=0.4.3


from snekmate.auth import ownable as ow
initializes: ow


number: public(uint256)


@deploy
def __init__():
    ow.__init__()


@external
def setNumber(newNumber: uint256):
    ow._check_owner()
    self.number = newNumber


@external
def increment():
    self.number += 1
