local M = {}

local urandom = assert(io.open("/dev/urandom", "rb"))

local function newUUID()
    local block = urandom:read(16)
    return string.format("%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x",
        block:byte(1), block:byte(2), block:byte(3), block:byte(4), block:byte(5), block:byte(6),
        (block:byte(7) / 16) + 64, block:byte(8), (block:byte(9) / 4) + 128, block:byte(10), block:byte(11, 16))
end

M.newUUID = newUUID
return M
