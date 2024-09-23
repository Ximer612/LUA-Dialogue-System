NPC = {
    ActualNpc = {},
    __tostring = function ()
        return "<" .. npc.name .. "> " .. "Hi!"
    end,

    interact = function (self)
        self.canInteract = false
        local tempResult = self.acualDialogue

        if type(self.acualDialogue) == "string" then
            self.dialogueText = tempResult
        else
            self.dialogueText = tempResult[1]
            self.possibleAnswers = tempResult[2]
        end
    end,

    answer = function (self, indexAnswer)
        if(self.hasInteracted == false or indexAnswer < 1 or indexAnswer > #self.possibleAnswers) then
            return nil
        end
        -- if the answer has another dialogue to the npc to say
        if type(self.acualDialogue[2][indexAnswer]) == "table" then
            local nextDialogue = self.acualDialogue[2][indexAnswer]
            self.acualDialogue = nextDialogue[2]
            self.dialogueText = self.acualDialogue[1]
            if type(self.acualDialogue[2]) == "table" then
                self.possibleAnswers = self.acualDialogue[2]
            else
                self.possibleAnswers = {self.acualDialogue[2]}
            end 
        else -- else end dialogue
            NPC.endDialogue(self)
            return self.acualDialogue[2][indexAnswer]
        end
    end,

    reset = function (self)
        self.canInteract = true
        self.dialogueIndex = math.random(#self.dialogues)
        self.acualDialogue = self.dialogues[self.dialogueIndex]
        self.dialogueText = ""
        self.possibleAnswers = {}
        NPC.ActualNpc = nil
    end,

    endDialogue = function (self)
        self:reset()
        print("Dialogue ended!")
    end,
    
    new = function (inName, inDialogues)
        npc = {}
        npc.dialogues = inDialogues
        npc.name = inName
        NPC.reset(npc)
        npc.dialogueText = ""
        npc.possibleAnswers = {}
        setmetatable(npc,NPC)
        --setmetatable(npc,{__index = NPC})
        NPC.__index = NPC
        return npc
    end,
}