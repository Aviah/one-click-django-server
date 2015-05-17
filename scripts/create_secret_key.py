# Create a SECRET_KEY, from django.utils.crypto

import hashlib
import random
import time
import sys

try:
    random = random.SystemRandom()
    using_sysrandom = True
except NotImplementedError:
    # A secure pseudo-random number generator is not available on your system. Falling back to Mersenne Twister.
    using_sysrandom = False
    
    
def get_random_string(length,allowed_chars,seed_input):
    """
    Returns a securely generated random string.

    The default length of 12 with the a-z, A-Z, 0-9 character set returns
    a 71-bit value. log_2((26+26+10)^12) =~ 71 bits
    """
    if not using_sysrandom:
        # This is ugly, and a hack, but it makes things better than
        # the alternative of predictability. This re-seeds the PRNG
        # using a value that is hard for an attacker to predict, every
        # time a random string is required. This may change the
        # properties of the chosen random sequence slightly, but this
        # is better than absolute predictability.
        random.seed(
            hashlib.sha256(
                ("%s%s%s" % (
                    random.getstate(),
                    time.time(),
                    seed_input)).encode('utf-8')
                ).digest())
    return ''.join(random.choice(allowed_chars) for i in range(length))  



chars = 'abcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*(-_=+)'
print get_random_string(50, chars,sys.argv[1])