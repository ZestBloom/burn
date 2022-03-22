'reach 0.1';
'use strict';
// -----------------------------------------------
// Name: Interface Template
// Description: NP Rapp simple
// Author: Nicholas Shellabarger
// Version: 0.0.2 - initial
// Requires Reach v0.1.7 (stable)
// ----------------------------------------------
export const Participants = () =>[
  Participant('Burner', {
    getParams: Fun([], Object({
      token: Token
    }))
  }),
  Participant('Relay', {})
]
export const Views = () => []
export const Api = () => [
  API({
    burn: Fun([UInt], Null)
  })
]
export const App = (map) => {
  const [[Burner, Relay], _, [a]] = map
  Burner.only(() => {
    const { token } = declassify(interact.getParams())
  })
  Burner.publish(token)
  const [keepGoing] =
  parallelReduce([true])
  .invariant(balance() >= 0 && balance(token) >= 0)
  .while(keepGoing)
  .api(a.burn,
    ((_) => assume(true)),
    ((m) => [0, [m, token]]),
    (_,k) => {
      k(null)
      return [true]
    })
  .timeout(false);
  commit();
  Relay.publish();
  transfer(balance()).to(Relay);
  transfer(balance(token), token).to(Relay);
  commit()
  exit()
}
// ----------------------------------------------
