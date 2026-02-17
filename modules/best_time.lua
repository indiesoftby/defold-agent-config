local M = {}

local SAVE_FILE = sys.get_save_file("game_catch_me", "best_time")

function M.get()
	local data = sys.load(SAVE_FILE)
	if data.best_time then
		return data.best_time
	end
	return nil
end

function M.set(time)
	local data = sys.load(SAVE_FILE)
	if not data.best_time or time > data.best_time then
		data.best_time = time
		sys.save(SAVE_FILE, data)
		return true
	end
	return false
end

function M.reset()
	sys.save(SAVE_FILE, {})
end

return M
