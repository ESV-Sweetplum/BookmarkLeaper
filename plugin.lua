function draw()
    local bookmarks = map.bookmarks

    imgui.Begin("BookmarkLeaper")

    local selectedIndex = state.GetValue("selectedIndex") or 0
    local times = {}

    imgui.Columns(3)

    imgui.Text("Time")
    imgui.NextColumn()
    imgui.Text("Bookmark Label")
    imgui.NextColumn()
    imgui.Text("Leap")
    imgui.NextColumn()

    imgui.Separator()

    local skippedBookmarks = 0

    for idx, v in pairs(bookmarks) do
        if (v.StartTime < 0) then
            skippedBookmarks = skippedBookmarks + 1
            goto continue
        end

        table.insert(times, v.StartTime)
        imgui.Text(v.StartTime)
        imgui.NextColumn()
        if (imgui.CalcTextSize(v.Note)[1] > 200) then
            local note = v.Note
            while (imgui.CalcTextSize(note)[1] > 190) do
                note = note:sub(1, #note - 1)
            end
            imgui.Text(note .. "...")
        else
            imgui.Text(v.Note)
        end
        imgui.NextColumn()
        if (imgui.Button("Go to #" .. idx - skippedBookmarks)) then
            actions.GoToObjects(v.StartTime)
        end
        imgui.NextColumn()

        ::continue::
    end

    local maxTimeLength = #tostring(math.max(table.unpack(times)))

    imgui.SetColumnWidth(0, maxTimeLength * 10)
    imgui.SetColumnWidth(1, 225)
    imgui.SetColumnWidth(2, 75)

    state.SetValue("selectedIndex", selectedIndex)

    imgui.End()
end

function getStartAndEndNoteOffsets()

end
