require "npc"

function love.load()

    local npc1Dialogue = {
        {
            "Question?",
                {
                    "End",
                    {"Answer with NPC answer", 
                        {"NPC Answer", "End"}},
                    {"Answer with NPC question", 
                        {"New question?", 
                            {"New answer", 
                            {"New answer with NPC answer", 
                                {"Last NPC answer", 
                                    "End"}
                            }
                            }
                        } 
                    }
                }
        },
        {
            "Hi! What's up?",  -- NPC QUESTION
                {
                    "Good :)", 
                    {"Bad :(", 
                        {"Why?", 
                            {
                            {"I don't like LUA!",
                                {"I don't like you! >:(", 
                                    "Ok"
                                }
                            }, 
                            "My tummy hurts." 
                            } 
                        } 
                    },
                    "Angry >:("
                }
        },
        {
            "Hello world?", 
                { "Hello!", 
                  "World!", 
                  {"Hello world?", 
                    {"Yeah, HELLO WORLD!", 
                        "Ok..."}
                    } 
                }
        }
    }

    local npc2Dialogue = {
        { 
            "Woof woof!", {"Good boy!", "Bad boy!", "Hello world!"}
        },
        {
            "Bark bark?", {{"Bark?", {"*gives you a bone*", "*throw it away*" }}, "Good boy." }
        }
    }

    npc1 = NPC.new("LUA",npc1Dialogue)
    npc2 = NPC.new("Dog",npc2Dialogue)
end

function love.keypressed( key)
    if tonumber(key) ~= nil then
        local pressedNumber = tonumber(key)
        if NPC.ActualNpc == nil then
            if pressedNumber == 1 then
                NPC.ActualNpc = npc1
                NPC.ActualNpc:interact()
            elseif pressedNumber == 2 then
                NPC.ActualNpc = npc2
                NPC.ActualNpc:interact()
            end
        else
            NPC.ActualNpc:answer(tonumber(key))
        end
    end
end

function love.draw()
    if NPC.ActualNpc ~= nil and NPC.ActualNpc.canInteract == false then
        love.graphics.print("<" .. NPC.ActualNpc.name .. "> " .. NPC.ActualNpc.dialogueText, 100, 100, 0, 2,2)

        for index, value in ipairs(NPC.ActualNpc.possibleAnswers) do
            local tmpText = value
            if type(value) == "table" then
                tmpText = value[1]
            end
            love.graphics.print("[".. index .. "] => " .. tmpText, 100, 200 + 50 * index, 0, 2, 2)
        end

    end
end