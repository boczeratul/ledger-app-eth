
bin/app.elf:     file format elf32-littlearm


Disassembly of section .text:

c0d00000 <main>:
  .color_dashboard = COLOR_APP_LIGHT,
  .header_text = CHAINID_UPCASE,
#endif // TARGET_BLUE
};

__attribute__((section(".boot"))) int main(int arg0) {
c0d00000:	b510      	push	{r4, lr}
c0d00002:	b092      	sub	sp, #72	; 0x48
c0d00004:	a80f      	add	r0, sp, #60	; 0x3c
#ifdef USE_LIB_ETHEREUM
    chain_config_t local_chainConfig;
    os_memmove(&local_chainConfig, &C_chain_config, sizeof(chain_config_t));
c0d00006:	491f      	ldr	r1, [pc, #124]	; (c0d00084 <main+0x84>)
c0d00008:	4479      	add	r1, pc
c0d0000a:	220c      	movs	r2, #12
c0d0000c:	f000 f862 	bl	c0d000d4 <os_memmove>
    unsigned int libcall_params[3];
    unsigned char coinName[sizeof(CHAINID_COINNAME)];
    strcpy(coinName, CHAINID_COINNAME);
c0d00010:	4817      	ldr	r0, [pc, #92]	; (c0d00070 <main+0x70>)
c0d00012:	900b      	str	r0, [sp, #44]	; 0x2c
c0d00014:	a80b      	add	r0, sp, #44	; 0x2c
#ifdef TARGET_BLUE
    unsigned char coinNameUP[sizeof(CHAINID_UPCASE)];
    strcpy(coinNameUP, CHAINID_UPCASE);
    local_chainConfig.header_text = coinNameUP;
#endif // TARGET_BLUE
    local_chainConfig.coinName = coinName;
c0d00016:	900f      	str	r0, [sp, #60]	; 0x3c
c0d00018:	466c      	mov	r4, sp
    BEGIN_TRY {
        TRY {
c0d0001a:	4620      	mov	r0, r4
c0d0001c:	f000 f8c6 	bl	c0d001ac <setjmp>
c0d00020:	8520      	strh	r0, [r4, #40]	; 0x28
c0d00022:	4914      	ldr	r1, [pc, #80]	; (c0d00074 <main+0x74>)
c0d00024:	4208      	tst	r0, r1
c0d00026:	d10f      	bne.n	c0d00048 <main+0x48>
c0d00028:	4668      	mov	r0, sp
c0d0002a:	f000 f851 	bl	c0d000d0 <try_context_set>
            // ensure syscall will accept us
            check_api_level(CX_COMPAT_APILEVEL);
c0d0002e:	2009      	movs	r0, #9
c0d00030:	f000 f87a 	bl	c0d00128 <check_api_level>
            // delegate to Ethereum app/lib
            libcall_params[0] = "Ethereum";
c0d00034:	a010      	add	r0, pc, #64	; (adr r0, c0d00078 <main+0x78>)
c0d00036:	900c      	str	r0, [sp, #48]	; 0x30
            libcall_params[1] = 0x100; // use the Init call, as we won't exit
c0d00038:	2001      	movs	r0, #1
c0d0003a:	0200      	lsls	r0, r0, #8
c0d0003c:	900d      	str	r0, [sp, #52]	; 0x34
c0d0003e:	a80f      	add	r0, sp, #60	; 0x3c
            libcall_params[2] = &local_chainConfig;
c0d00040:	900e      	str	r0, [sp, #56]	; 0x38
c0d00042:	a80c      	add	r0, sp, #48	; 0x30
            os_lib_call(&libcall_params);
c0d00044:	f000 f89c 	bl	c0d00180 <os_lib_call>
        }
        FINALLY {
c0d00048:	f000 f864 	bl	c0d00114 <try_context_get>
c0d0004c:	4669      	mov	r1, sp
c0d0004e:	4288      	cmp	r0, r1
c0d00050:	d103      	bne.n	c0d0005a <main+0x5a>
c0d00052:	f000 f861 	bl	c0d00118 <try_context_get_previous>
c0d00056:	f000 f83b 	bl	c0d000d0 <try_context_set>
            app_exit();
c0d0005a:	f000 f815 	bl	c0d00088 <app_exit>
c0d0005e:	4668      	mov	r0, sp
        }
    }
    END_TRY;
c0d00060:	8d00      	ldrh	r0, [r0, #40]	; 0x28
c0d00062:	2800      	cmp	r0, #0
c0d00064:	d102      	bne.n	c0d0006c <main+0x6c>
        }
        END_TRY;
    }
	  app_exit();
#endif
    return 0;
c0d00066:	2000      	movs	r0, #0
c0d00068:	b012      	add	sp, #72	; 0x48
c0d0006a:	bd10      	pop	{r4, pc}
        }
        FINALLY {
            app_exit();
        }
    }
    END_TRY;
c0d0006c:	f000 f84d 	bl	c0d0010a <os_longjmp>
c0d00070:	004e5844 	.word	0x004e5844
c0d00074:	0000ffff 	.word	0x0000ffff
c0d00078:	65687445 	.word	0x65687445
c0d0007c:	6d756572 	.word	0x6d756572
c0d00080:	00000000 	.word	0x00000000
c0d00084:	000002cc 	.word	0x000002cc

c0d00088 <app_exit>:

    // command has been processed, DO NOT reset the current APDU transport
    return 1;
}

void app_exit(void) {
c0d00088:	b510      	push	{r4, lr}
c0d0008a:	b08c      	sub	sp, #48	; 0x30
c0d0008c:	ac01      	add	r4, sp, #4

    BEGIN_TRY_L(exit) {
        TRY_L(exit) {
c0d0008e:	4620      	mov	r0, r4
c0d00090:	f000 f88c 	bl	c0d001ac <setjmp>
c0d00094:	8520      	strh	r0, [r4, #40]	; 0x28
c0d00096:	490d      	ldr	r1, [pc, #52]	; (c0d000cc <app_exit+0x44>)
c0d00098:	4208      	tst	r0, r1
c0d0009a:	d106      	bne.n	c0d000aa <app_exit+0x22>
c0d0009c:	a801      	add	r0, sp, #4
c0d0009e:	f000 f817 	bl	c0d000d0 <try_context_set>
            os_sched_exit(-1);
c0d000a2:	2000      	movs	r0, #0
c0d000a4:	43c0      	mvns	r0, r0
c0d000a6:	f000 f855 	bl	c0d00154 <os_sched_exit>
        }
        FINALLY_L(exit) {
c0d000aa:	f000 f833 	bl	c0d00114 <try_context_get>
c0d000ae:	a901      	add	r1, sp, #4
c0d000b0:	4288      	cmp	r0, r1
c0d000b2:	d103      	bne.n	c0d000bc <app_exit+0x34>
c0d000b4:	f000 f830 	bl	c0d00118 <try_context_get_previous>
c0d000b8:	f000 f80a 	bl	c0d000d0 <try_context_set>
c0d000bc:	a801      	add	r0, sp, #4

        }
    }
    END_TRY_L(exit);
c0d000be:	8d00      	ldrh	r0, [r0, #40]	; 0x28
c0d000c0:	2800      	cmp	r0, #0
c0d000c2:	d101      	bne.n	c0d000c8 <app_exit+0x40>
}
c0d000c4:	b00c      	add	sp, #48	; 0x30
c0d000c6:	bd10      	pop	{r4, pc}
        }
        FINALLY_L(exit) {

        }
    }
    END_TRY_L(exit);
c0d000c8:	f000 f81f 	bl	c0d0010a <os_longjmp>
c0d000cc:	0000ffff 	.word	0x0000ffff

c0d000d0 <try_context_set>:
  //                ^ platform register
  return (try_context_t*) current_ctx->jmp_buf[5];
}

void try_context_set(try_context_t* ctx) {
  __asm volatile ("mov r9, %0"::"r"(ctx));
c0d000d0:	4681      	mov	r9, r0
}
c0d000d2:	4770      	bx	lr

c0d000d4 <os_memmove>:
  }
}

#endif // HAVE_USB_APDU

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
c0d000d4:	b5b0      	push	{r4, r5, r7, lr}
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
c0d000d6:	4288      	cmp	r0, r1
c0d000d8:	d90d      	bls.n	c0d000f6 <os_memmove+0x22>
    while(length--) {
c0d000da:	2a00      	cmp	r2, #0
c0d000dc:	d014      	beq.n	c0d00108 <os_memmove+0x34>
c0d000de:	1e49      	subs	r1, r1, #1
c0d000e0:	4252      	negs	r2, r2
c0d000e2:	1e40      	subs	r0, r0, #1
c0d000e4:	2300      	movs	r3, #0
c0d000e6:	43db      	mvns	r3, r3
      DSTCHAR[length] = SRCCHAR[length];
c0d000e8:	461c      	mov	r4, r3
c0d000ea:	4354      	muls	r4, r2
c0d000ec:	5d0d      	ldrb	r5, [r1, r4]
c0d000ee:	5505      	strb	r5, [r0, r4]

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
    while(length--) {
c0d000f0:	1c52      	adds	r2, r2, #1
c0d000f2:	d1f9      	bne.n	c0d000e8 <os_memmove+0x14>
c0d000f4:	e008      	b.n	c0d00108 <os_memmove+0x34>
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d000f6:	2a00      	cmp	r2, #0
c0d000f8:	d006      	beq.n	c0d00108 <os_memmove+0x34>
c0d000fa:	2300      	movs	r3, #0
      DSTCHAR[l] = SRCCHAR[l];
c0d000fc:	b29c      	uxth	r4, r3
c0d000fe:	5d0d      	ldrb	r5, [r1, r4]
c0d00100:	5505      	strb	r5, [r0, r4]
      l++;
c0d00102:	1c5b      	adds	r3, r3, #1
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d00104:	1e52      	subs	r2, r2, #1
c0d00106:	d1f9      	bne.n	c0d000fc <os_memmove+0x28>
      DSTCHAR[l] = SRCCHAR[l];
      l++;
    }
  }
#undef DSTCHAR
}
c0d00108:	bdb0      	pop	{r4, r5, r7, pc}

c0d0010a <os_longjmp>:
void try_context_set(try_context_t* ctx) {
  __asm volatile ("mov r9, %0"::"r"(ctx));
}

#ifndef HAVE_BOLOS
void os_longjmp(unsigned int exception) {
c0d0010a:	b580      	push	{r7, lr}
c0d0010c:	4601      	mov	r1, r0
  return xoracc;
}

try_context_t* try_context_get(void) {
  try_context_t* current_ctx;
  __asm volatile ("mov %0, r9":"=r"(current_ctx));
c0d0010e:	4648      	mov	r0, r9
  __asm volatile ("mov r9, %0"::"r"(ctx));
}

#ifndef HAVE_BOLOS
void os_longjmp(unsigned int exception) {
  longjmp(try_context_get()->jmp_buf, exception);
c0d00110:	f000 f858 	bl	c0d001c4 <longjmp>

c0d00114 <try_context_get>:
  return xoracc;
}

try_context_t* try_context_get(void) {
  try_context_t* current_ctx;
  __asm volatile ("mov %0, r9":"=r"(current_ctx));
c0d00114:	4648      	mov	r0, r9
  return current_ctx;
c0d00116:	4770      	bx	lr

c0d00118 <try_context_get_previous>:
}

try_context_t* try_context_get_previous(void) {
c0d00118:	2000      	movs	r0, #0
  try_context_t* current_ctx;
  __asm volatile ("mov %0, r9":"=r"(current_ctx));
c0d0011a:	4649      	mov	r1, r9

  // first context reached ?
  if (current_ctx == NULL) {
c0d0011c:	2900      	cmp	r1, #0
c0d0011e:	d000      	beq.n	c0d00122 <try_context_get_previous+0xa>
  }

  // return r9 content saved on the current context. It links to the previous context.
  // r4 r5 r6 r7 r8 r9 r10 r11 sp lr
  //                ^ platform register
  return (try_context_t*) current_ctx->jmp_buf[5];
c0d00120:	6948      	ldr	r0, [r1, #20]
}
c0d00122:	4770      	bx	lr

c0d00124 <SVC_Call>:
  // avoid a separate asm file, but avoid any intrusion from the compiler
  unsigned int SVC_Call(unsigned int syscall_id, unsigned int * parameters) __attribute__ ((naked));
  //                    r0                       r1
  unsigned int SVC_Call(unsigned int syscall_id, unsigned int * parameters) {
    // delegate svc
    asm volatile("svc #1":::"r0","r1");
c0d00124:	df01      	svc	1
    // directly return R0 value
    asm volatile("bx  lr");
c0d00126:	4770      	bx	lr

c0d00128 <check_api_level>:
  }
  void check_api_level ( unsigned int apiLevel ) 
{
c0d00128:	b580      	push	{r7, lr}
c0d0012a:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0+1];
  parameters[0] = (unsigned int)apiLevel;
c0d0012c:	9000      	str	r0, [sp, #0]
  retid = SVC_Call(SYSCALL_check_api_level_ID_IN, parameters);
c0d0012e:	4807      	ldr	r0, [pc, #28]	; (c0d0014c <check_api_level+0x24>)
c0d00130:	4669      	mov	r1, sp
c0d00132:	f7ff fff7 	bl	c0d00124 <SVC_Call>
c0d00136:	aa01      	add	r2, sp, #4
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d00138:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_check_api_level_ID_OUT) {
c0d0013a:	4905      	ldr	r1, [pc, #20]	; (c0d00150 <check_api_level+0x28>)
c0d0013c:	4288      	cmp	r0, r1
c0d0013e:	d101      	bne.n	c0d00144 <check_api_level+0x1c>
    THROW(EXCEPTION_SECURITY);
  }
}
c0d00140:	b002      	add	sp, #8
c0d00142:	bd80      	pop	{r7, pc}
  unsigned int parameters [0+1];
  parameters[0] = (unsigned int)apiLevel;
  retid = SVC_Call(SYSCALL_check_api_level_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_check_api_level_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d00144:	2004      	movs	r0, #4
c0d00146:	f7ff ffe0 	bl	c0d0010a <os_longjmp>
c0d0014a:	46c0      	nop			; (mov r8, r8)
c0d0014c:	60000137 	.word	0x60000137
c0d00150:	900001c6 	.word	0x900001c6

c0d00154 <os_sched_exit>:
  }
  return (unsigned int)ret;
}

void os_sched_exit ( unsigned int exit_code ) 
{
c0d00154:	b580      	push	{r7, lr}
c0d00156:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0+1];
  parameters[0] = (unsigned int)exit_code;
c0d00158:	9000      	str	r0, [sp, #0]
  retid = SVC_Call(SYSCALL_os_sched_exit_ID_IN, parameters);
c0d0015a:	4807      	ldr	r0, [pc, #28]	; (c0d00178 <os_sched_exit+0x24>)
c0d0015c:	4669      	mov	r1, sp
c0d0015e:	f7ff ffe1 	bl	c0d00124 <SVC_Call>
c0d00162:	aa01      	add	r2, sp, #4
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d00164:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_os_sched_exit_ID_OUT) {
c0d00166:	4905      	ldr	r1, [pc, #20]	; (c0d0017c <os_sched_exit+0x28>)
c0d00168:	4288      	cmp	r0, r1
c0d0016a:	d101      	bne.n	c0d00170 <os_sched_exit+0x1c>
    THROW(EXCEPTION_SECURITY);
  }
}
c0d0016c:	b002      	add	sp, #8
c0d0016e:	bd80      	pop	{r7, pc}
  unsigned int parameters [0+1];
  parameters[0] = (unsigned int)exit_code;
  retid = SVC_Call(SYSCALL_os_sched_exit_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_os_sched_exit_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d00170:	2004      	movs	r0, #4
c0d00172:	f7ff ffca 	bl	c0d0010a <os_longjmp>
c0d00176:	46c0      	nop			; (mov r8, r8)
c0d00178:	600062e1 	.word	0x600062e1
c0d0017c:	9000626f 	.word	0x9000626f

c0d00180 <os_lib_call>:
  }
  return (unsigned int)ret;
}

unsigned int os_lib_call ( unsigned int * call_parameters ) 
{
c0d00180:	b580      	push	{r7, lr}
c0d00182:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0+1];
  parameters[0] = (unsigned int)call_parameters;
c0d00184:	9000      	str	r0, [sp, #0]
  retid = SVC_Call(SYSCALL_os_lib_call_ID_IN, parameters);
c0d00186:	4807      	ldr	r0, [pc, #28]	; (c0d001a4 <os_lib_call+0x24>)
c0d00188:	4669      	mov	r1, sp
c0d0018a:	f7ff ffcb 	bl	c0d00124 <SVC_Call>
c0d0018e:	aa01      	add	r2, sp, #4
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d00190:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_os_lib_call_ID_OUT) {
c0d00192:	4905      	ldr	r1, [pc, #20]	; (c0d001a8 <os_lib_call+0x28>)
c0d00194:	4288      	cmp	r0, r1
c0d00196:	d102      	bne.n	c0d0019e <os_lib_call+0x1e>
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d00198:	9801      	ldr	r0, [sp, #4]
c0d0019a:	b002      	add	sp, #8
c0d0019c:	bd80      	pop	{r7, pc}
  unsigned int parameters [0+1];
  parameters[0] = (unsigned int)call_parameters;
  retid = SVC_Call(SYSCALL_os_lib_call_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_os_lib_call_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d0019e:	2004      	movs	r0, #4
c0d001a0:	f7ff ffb3 	bl	c0d0010a <os_longjmp>
c0d001a4:	6000650b 	.word	0x6000650b
c0d001a8:	90006515 	.word	0x90006515

c0d001ac <setjmp>:
c0d001ac:	c0f0      	stmia	r0!, {r4, r5, r6, r7}
c0d001ae:	4641      	mov	r1, r8
c0d001b0:	464a      	mov	r2, r9
c0d001b2:	4653      	mov	r3, sl
c0d001b4:	465c      	mov	r4, fp
c0d001b6:	466d      	mov	r5, sp
c0d001b8:	4676      	mov	r6, lr
c0d001ba:	c07e      	stmia	r0!, {r1, r2, r3, r4, r5, r6}
c0d001bc:	3828      	subs	r0, #40	; 0x28
c0d001be:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d001c0:	2000      	movs	r0, #0
c0d001c2:	4770      	bx	lr

c0d001c4 <longjmp>:
c0d001c4:	3010      	adds	r0, #16
c0d001c6:	c87c      	ldmia	r0!, {r2, r3, r4, r5, r6}
c0d001c8:	4690      	mov	r8, r2
c0d001ca:	4699      	mov	r9, r3
c0d001cc:	46a2      	mov	sl, r4
c0d001ce:	46ab      	mov	fp, r5
c0d001d0:	46b5      	mov	sp, r6
c0d001d2:	c808      	ldmia	r0!, {r3}
c0d001d4:	3828      	subs	r0, #40	; 0x28
c0d001d6:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d001d8:	1c08      	adds	r0, r1, #0
c0d001da:	d100      	bne.n	c0d001de <longjmp+0x1a>
c0d001dc:	2001      	movs	r0, #1
c0d001de:	4718      	bx	r3
c0d001e0:	59006f4e 	.word	0x59006f4e
c0d001e4:	43007365 	.word	0x43007365
c0d001e8:	72746e6f 	.word	0x72746e6f
c0d001ec:	20746361 	.word	0x20746361
c0d001f0:	61746164 	.word	0x61746164
c0d001f4:	73694400 	.word	0x73694400
c0d001f8:	79616c70 	.word	0x79616c70
c0d001fc:	74616420 	.word	0x74616420
c0d00200:	61420061 	.word	0x61420061
c0d00204:	56006b63 	.word	0x56006b63
c0d00208:	69737265 	.word	0x69737265
c0d0020c:	31006e6f 	.word	0x31006e6f
c0d00210:	312e322e 	.word	0x312e322e
c0d00214:	65735500 	.word	0x65735500
c0d00218:	6c617720 	.word	0x6c617720
c0d0021c:	2074656c 	.word	0x2074656c
c0d00220:	76006f74 	.word	0x76006f74
c0d00224:	20776569 	.word	0x20776569
c0d00228:	6f636361 	.word	0x6f636361
c0d0022c:	73746e75 	.word	0x73746e75
c0d00230:	74655300 	.word	0x74655300
c0d00234:	676e6974 	.word	0x676e6974
c0d00238:	62410073 	.word	0x62410073
c0d0023c:	0074756f 	.word	0x0074756f
c0d00240:	74697551 	.word	0x74697551
c0d00244:	70706120 	.word	0x70706120
c0d00248:	6e6f4300 	.word	0x6e6f4300
c0d0024c:	6d726966 	.word	0x6d726966
c0d00250:	64646100 	.word	0x64646100
c0d00254:	73736572 	.word	0x73736572
c0d00258:	64644100 	.word	0x64644100
c0d0025c:	73736572 	.word	0x73736572
c0d00260:	61727400 	.word	0x61727400
c0d00264:	6361736e 	.word	0x6361736e
c0d00268:	6e6f6974 	.word	0x6e6f6974
c0d0026c:	52415700 	.word	0x52415700
c0d00270:	474e494e 	.word	0x474e494e
c0d00274:	74614400 	.word	0x74614400
c0d00278:	72702061 	.word	0x72702061
c0d0027c:	6e657365 	.word	0x6e657365
c0d00280:	6d410074 	.word	0x6d410074
c0d00284:	746e756f 	.word	0x746e756f
c0d00288:	78614d00 	.word	0x78614d00
c0d0028c:	6d756d69 	.word	0x6d756d69
c0d00290:	65656620 	.word	0x65656620
c0d00294:	69530073 	.word	0x69530073
c0d00298:	74206e67 	.word	0x74206e67
c0d0029c:	6d006568 	.word	0x6d006568
c0d002a0:	61737365 	.word	0x61737365
c0d002a4:	4d006567 	.word	0x4d006567
c0d002a8:	61737365 	.word	0x61737365
c0d002ac:	68206567 	.word	0x68206567
c0d002b0:	00687361 	.word	0x00687361
c0d002b4:	656c6573 	.word	0x656c6573
c0d002b8:	726f7463 	.word	0x726f7463
c0d002bc:	6c655300 	.word	0x6c655300
c0d002c0:	6f746365 	.word	0x6f746365
c0d002c4:	61700072 	.word	0x61700072
c0d002c8:	656d6172 	.word	0x656d6172
c0d002cc:	00726574 	.word	0x00726574
c0d002d0:	204e5844 	.word	0x204e5844
c0d002d4:	00000000 	.word	0x00000000

c0d002d8 <C_chain_config>:
c0d002d8:	c0d002d0 000000ed 00000016              ............

c0d002e4 <_etext>:
	...
