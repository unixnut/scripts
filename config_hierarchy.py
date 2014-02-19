"""Mainly provides the ConfigHierarchy class."""


class LevelError(LookupError):
    """A value was attempted to be assigned to an item that is a level.
    
    """
    pass


class ConfigHierarchy:
    """Represents a hierarchy of configuration values where each item in a
    given level is either a string value or a dictionary representing a lower
    level.
    
    """
    def __init__(self, allow_checking_dicts = False):
        self.allow_checking_dicts = allow_checking_dicts
        self.config_dict = {}


    def __setitem__(self, levels, value):
        """Insert a value into the hierarchy."""
        # make the nest of dictionaries (the last element is a value not a
        # dictionary, so only process the levels above it)
        curr = self.config_dict
        for level in levels[:-1]:
            # check if there is already a dictionary for the current item
            if level not in curr:
                # make this item a dictionary holding the items of the level below
                curr[level] = {}
            # descend to the level below
            curr = curr[level]
        
        # now handle the last level: insert or replace the value, but not if
        # that item exists and isn't a string (e.g. it's a lower level)
        level = levels[-1]
        if level not in curr or isinstance(curr[level], basestring):
            curr[level] = value
        else:
            raise LevelError(level + " is a level so can't insert a value there") 


    def __getitem__(self, levels):
        """Return the value from a given level in the hierarchy."""
        item = self._locate_item(levels)
        if isinstance(item, basestring):
            return item
        else:
            raise ValueError("item is not a string value")


    def get(self, levels, d=None):
        """Return the value from a given level in the hierarchy, or d if there
        is no node there.  d defaults to None."""
        try:
            item = self._locate_item(levels)
        except KeyError:
            return d
        
        if isinstance(item, basestring):
            return item
        else:
            raise ValueError("item is not a string value")


    def has_key(self, levels):
        """Return True if the requested item has a string value or False if
        the item doesn't exist.  Throw KeyError if the item is actually a
        lower level, as that indicates the caller doesn't know where to look
        for values (unless overridden at construction).
        
        This used to be called __contains__() but you can't get something
        upon which to use the "in" operator and still maintain safety.
        
        """
        try:
            found = self._locate_item(levels)
        except KeyError:
            return False
        
        if isinstance(found, basestring):
            return True
        else:
            raise LevelError("no value at that location")


    def has_node(self, levels):
        """Return True if the requested item exists or False if
        the item doesn't exist.  For extra safety, use has_key() instead."""
        try:
            self._locate_item(levels)
            return True
        except KeyError:
            return False


    def iterkeys(self, levels):
        """Return an iterator over the keys of the given level, thus
        preserving the abstraction."""
        item = self._locate_item(levels)
        if isinstance(item, dict):
            return item.iterkeys()
        else:
            raise LevelError("Requested item is a string value")


    def keys(self, levels):
        """Return a list of keys at the given level."""
        item = self._locate_item(levels)
        if isinstance(item, dict):
            return item.keys()
        else:
            raise LevelError("Requested item is a string value")


    # == internal methods ==
    def _locate_item(self, levels):
        """Find a given item in the hierarchy."""
        curr = self.config_dict
        for level in levels:
            # check if there is already a dictionary for the current item
            if level not in curr:
                raise KeyError(level + " not present")
            # descend to the level below
            curr = curr[level]
        return curr

