void main(void)
{
    const char *str = "                                 Hello, world!";
    char *vidptr = (char*)0xb8000;
    unsigned int i = 0;
    unsigned int j = 0;
    
    while(str[j] != '\0') {
        vidptr[i] = str[j];
        vidptr[i+1] = 0xFC;
        ++j;
        i = i + 2;
    }
    return;
}