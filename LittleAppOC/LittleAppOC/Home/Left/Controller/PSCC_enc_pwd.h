#ifndef _PSCC_ENC_PWD_H_
#define _PSCC_ENC_PWD_H_


#define SHA256_MAC_SIZE		32
extern void sha256_mac(unsigned char *data,unsigned int dataLen,unsigned char mac[SHA256_MAC_SIZE]);

extern int base64_decode(unsigned char *data,unsigned int dataLen, unsigned char **decData,unsigned int *decDataLen);
extern int base64_encode(unsigned char *data,unsigned int dataLen,unsigned char **encData,unsigned int *encDataLen);


#define AES256_KEY_SIZE		32
extern long aes256_cbc_enc(unsigned char *data,unsigned int dataLen,unsigned char **encData,unsigned int *encDataLen,unsigned char key[AES256_KEY_SIZE]);
extern long aes256_cbc_dec(unsigned char *data,unsigned int dataLen,unsigned char **decData,unsigned int *decDataLen,unsigned char key[AES256_KEY_SIZE]);


//////////////////////////////////////////////////////////////////////////
extern long EncryptPassword(const char *strPwd, char **encData, unsigned int *encDataLen);


#endif
