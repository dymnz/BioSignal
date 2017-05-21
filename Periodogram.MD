### Periodogram

Source: https://en.wikipedia.org/wiki/Spectral_density#Power_spectral_density

---
#### Definition of PSD 


![](https://wikimedia.org/api/rest_v1/media/math/render/svg/c46bd1326f3318c991eead326aced04fa5cbc3c6)

![](https://wikimedia.org/api/rest_v1/media/math/render/svg/270af296fa27bc5be64f948baa08ebd6049e6c4c)



---

#### PSD
![](https://wikimedia.org/api/rest_v1/media/math/render/svg/2c06fa8cbaf57438cc9f95571b25d15ad89c717a) - [1]

---

#### Estimate of PSD

This definition of the power spectral density can be generalized to discrete time variables 
![](https://wikimedia.org/api/rest_v1/media/math/render/svg/7c5ea190699149306d242b70439e663559e3ffbe)
. As above we can consider a finite window of ![](https://wikimedia.org/api/rest_v1/media/math/render/svg/684dfffc7b19e148dac524a256e6209445887051)
with the signal sampled at discrete times ![](https://wikimedia.org/api/rest_v1/media/math/render/svg/d8569943fad34048331303a7d860286f1d3168c6)
for a total measurement period ![](https://wikimedia.org/api/rest_v1/media/math/render/svg/341d2c64e98d43248898e0aafe08070ca86ef40f).
Then a single **estimate of the PSD** can be obtained through summation rather than integration:

![](https://wikimedia.org/api/rest_v1/media/math/render/svg/d098065dfd01c25b8d88557bdbbe96caae65dfe3) - [2]


**This computed PSD is sometimes called a periodogram.
This periodogram converges to the true PSD as the number of estimates as well as the averaging 
time interval T approach infinity (Brown & Hwang[12]).**

---

#### Conclusion

Continuous **infinite** integral [1]: PSD

Discrete **finite** summation [2]: Periodogram, **"estimate of the PSD"**

-> Both are FT of ACF. Just that the latter is finite, and is seen as the windowed version of the former (referred in lectrue note)



---


1. > acf經過fft之後就是periodogram是這樣說的嗎？

看是finite還是infinite

2. > 他是要透過acf的結果去預測嗎？

Finite的結果是對於Infinite的預測

3. > 況且acf的結果是檢測自己的period跟peridogram有什麼直接的關係？

ACF可以讓我們知道一個訊號移動幾點後會重複出現; ACF的輸出的週期會等於輸入訊號的週期:

https://en.wikipedia.org/wiki/Autocorrelation#Properties
> The autocorrelation of a periodic function is, itself, periodic with the same period.

我們找的是輸入訊號的PSD, 從Definition of PSD可以看到PSD就是輸入訊號Power的期望值, 也就是輸入訊號的FT的平方的期望值.

既然ACF的輸出的週期和輸入訊號週期相同, 那頻率成份也會相同, 所以我們可以用ACF找到輸入訊號的PSD.

4. > 還有啊～time series這邊所用到的觀念有跟random porcess有關麻

沒什麼關係, Random process也不會教這麼細只能自己看

