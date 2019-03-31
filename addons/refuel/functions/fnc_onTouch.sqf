/*

* FUNC(onTouch)
    * creates PFH that checks a tank (in its role as source), and calls FUNC(stream) on every one of them
    * PFH gets stored in a namespace within missionNamespace (like, GVAR(flows) containing a map of sink => pfh
    * self-removes if not connected to anything for $timeout (uncritical, could be as less as 1s, could be as much as a minute? it's more a GC thing)
    */
