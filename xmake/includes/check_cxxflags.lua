--!A cross-platform build utility based on Lua
--
-- Licensed to the Apache Software Foundation (ASF) under one
-- or more contributor license agreements.  See the NOTICE file
-- distributed with this work for additional information
-- regarding copyright ownership.  The ASF licenses this file
-- to you under the Apache License, Version 2.0 (the
-- "License"); you may not use this file except in compliance
-- with the License.  You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
-- 
-- Copyright (C) 2015 - 2019, TBOOX Open Source Group.
--
-- @author      ruki
-- @file        check_cxxflags.lua
--

-- check c++ flags and add macro definition 
--
-- e.g.
--
-- check_cxxflags("HAS_SSE2", "-msse2")
-- check_cxxflags("HAS_SSE2", {"-msse2", "/arch:SSE2"})
--
function check_cxxflags(definition, flags, opt)
    opt = opt or {}
    local optname = "__" .. (opt.name or definition)
    option(optname)
        add_defines(definition)
        on_check(function (option)
            import("core.tool.compiler")
            if compiler.has_flags("cxx", flags, opt) then
                option:enable(true)
            end
        end)
    option_end()
    add_options(optname)
end

-- check c++ flags and add macro definition to the configuration flags 
--
-- e.g.
--
-- configvar_check_cxxflags("HAS_SSE2", "-msse2")
-- configvar_check_cxxflags("HAS_SSE2", {"-msse2", "/arch:SSE2"})
--
function configvar_check_cxxflags(definition, flags, opt)
    opt = opt or {}
    local optname = "__" .. (opt.name or definition)
    option(optname)
        set_configvar(definition, 1)
        on_check(function (option)
            import("core.tool.compiler")
            if compiler.has_flags("cxx", flags, opt) then
                option:enable(true)
            end
        end)
    option_end()
    add_options(optname)
end