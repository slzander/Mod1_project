Game.destroy_all
User.destroy_all
SecretWord.destroy_all

SecretWord.create(word: 'crapplet', hint: 'A poorly created or implemented applet', difficulty: 1)
SecretWord.create(word: 'dribbleware', hint: 'Software released without proper testing, that needs patches to fix it', difficulty: 2)
SecretWord.create(word: 'cowboy coding', hint: 'Writing code according to one’s own rules, instead of convention', difficulty: 2)
SecretWord.create(word: 'rubber ducking', hint: 'Explaining programming problems to someone that knows nothing about programming', difficulty: 2)
SecretWord.create(word: 'refuctoring', hint: 'Taking good code and making it unmaintainable to anyone but yourself', difficulty: 3)
SecretWord.create(word: 'a duck', hint:'A feature added to draw attention, with the intention of being removed', difficulty: 1)
SecretWord.create(word: 'common law feature', hint: 'A bug that has existed for so long that is is considered a feature', difficulty: 3)
SecretWord.create(word: 'hydra', hint:'A bug that introduces more bugs upon attempting to fix it', difficulty: 1)
SecretWord.create(word: 'cut and waste code', hint:'Cutting and pasting online code', difficulty: 3)

