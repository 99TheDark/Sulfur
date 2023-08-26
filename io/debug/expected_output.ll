@__const.function.firstName = private unnamed_addr constant [6 x i8] c"John \00", align 1
@__const.function.lastName = private unnamed_addr constant [4 x i8] c"Doe\00", align 1

define dso_local void @function() {
entry:
  %firstName = alloca [6 x i8], align 1
  %lastName = alloca [4 x i8], align 1
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %firstName, ptr align 1 @__const.function.firstName, i64 6, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %lastName, ptr align 1 @__const.function.lastName, i64 4, i1 false)
  %arraydecay = getelementptr inbounds [6 x i8], ptr %firstName, i64 0, i64 0
  %arraydecay1 = getelementptr inbounds [4 x i8], ptr %lastName, i64 0, i64 0
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %arraydecay, ptr align 1 %arraydecay1, i64 3, i1 false)
  ret void
}

declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #2
