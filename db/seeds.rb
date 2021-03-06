Game.destroy_all
User.destroy_all
SecretWord.destroy_all
HighScore.destroy_all

# SecretWord.create(word: 'cowboy coding', hint: 'Writing code according to one’s own rules, instead of convention', difficulty: 2)
# SecretWord.create(word: 'common law feature', hint: 'A bug that has existed for so long that is is considered a feature', difficulty: 3)
# SecretWord.create(word: 'rubber ducking', hint: 'Explaining programming problems to someone that knows nothing about programming', difficulty: 2)
# SecretWord.create(word: 'a duck', hint:'A feature added to draw attention, with the intention of being removed', difficulty: 1)
# SecretWord.create(word: 'code', hint:'The language programmers use to tell a computer what to do', difficulty: 1)
SecretWord.create(word: 'gem', hint:'A software package offering functionalities to ruby programs', difficulty: 1)
SecretWord.create(word: 'shell', hint:'A user interface for accessing an operating systems services', difficulty: 1)
SecretWord.create(word: 'bash', hint:'A Unix shell and command language written by Brian Fox', difficulty: 1)
SecretWord.create(word: 'bug', hint:'An error in a program preventing it from running as expected', difficulty: 1)
SecretWord.create(word: 'git', hint:'A version control system', difficulty: 1)
SecretWord.create(word: 'loop', hint: 'A sequence of instructions that is continually repeated', difficulty: 1)
SecretWord.create(word: 'crapplet', hint: 'Slang for a poorly created or implemented applet', difficulty: 2)
SecretWord.create(word: 'hydra', hint:'Slang for a bug that introduces more bugs upon attempting to fix it', difficulty: 2)
SecretWord.create(word: 'javascript', hint:'Code that adds interactivity and animation to webpages', difficulty: 2)
SecretWord.create(word: 'debugging', hint:'Finding and fixing problems in a program', difficulty: 2)
SecretWord.create(word: 'parameter', hint:'A variable in a method definition', difficulty: 2)
SecretWord.create(word: 'argument', hint:'A value that is passed in to a command or function', difficulty: 2)
SecretWord.create(word: 'command', hint:'An instruction for a computer', difficulty: 2)
SecretWord.create(word: 'boolean', hint:'A value that is either true or false', difficulty: 2)
SecretWord.create(word: 'compiler', hint:'A program that converts instructions into a machine-code', difficulty: 2)
SecretWord.create(word: 'concatenate', hint:'Combine string, text, or other data in a series without gaps', difficulty: 3)
SecretWord.create(word: 'instantiation', hint:'The realization of a predefined object', difficulty: 3)
SecretWord.create(word: 'recursion', hint:'When a program has a part that requires the application of the whole', difficulty: 3)
SecretWord.create(word: 'semantics', hint:'The mathematical study of the meaning of programming languages', difficulty: 3)
SecretWord.create(word: 'dribbleware', hint: 'Slang for software released without proper testing, that needs patches to fix it', difficulty: 3)
SecretWord.create(word: 'refuctoring', hint: 'Slang for taking good code and making it unmaintainable to anyone but yourself', difficulty: 3)
SecretWord.create(word: 'inheritance', hint: 'The ability for classes to receive the properties and methods of other classes.', difficulty: 3)
    
HighScore.create(user_name:'no one', score: 1)